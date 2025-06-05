import React, { useState, useMemo } from 'react';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Package, ChevronDown, ChevronRight, ChevronLeft, ChevronRight as ChevronRightIcon, ChevronsLeft, ChevronsRight } from 'lucide-react';
import { cn } from '@/lib/utils';
import ProductTableColumns from '@/components/products/ProductTableColumns';
import { useQuery } from '@tanstack/react-query';
import { supabase } from '@/integrations/supabase/client';

export interface StockItem {
  product_id: string;
  product_name: string;
  product_code: string;
  generic_name: string;
  batch_id: string;
  batch_number: string;
  expiry_date: string;
  location_type: string;
  location_id: string;
  current_quantity_strips: number;
  cost_per_strip: number;
  total_value: number;
  category_name?: string;
  min_stock_level_godown?: number;
  min_stock_level_mr?: number;
}

export interface GroupedStockItem {
  product_id: string;
  product_name: string;
  product_code: string;
  generic_name: string;
  category_name?: string;
  total_quantity_strips: number;
  total_value: number;
  batch_count: number;
  batches: StockItem[];
  min_stock_level_godown?: number;
  min_stock_level_mr?: number;
}

export interface StockColumnConfig extends Record<string, boolean> {
  product: boolean;
  genericName: boolean;
  batchNumber: boolean;
  expiryDate: boolean;
  location: boolean;
  currentQuantityStrips: boolean;
  currentQuantityDisplay: boolean;
  costPerStrip: boolean;
  totalValue: boolean;
  stockStatus: boolean;
  expiryStatus: boolean;
}

export const GROUPED_STOCK_TABLE_COLUMNS = [
  { key: 'product', label: 'Product' },
  { key: 'genericName', label: 'Generic Name' },
  { key: 'batchCount', label: 'Batches' },
  { key: 'currentQuantityStrips', label: 'Total Qty (Strips)' },
  { key: 'currentQuantityDisplay', label: 'Total Qty (Display)' },
  { key: 'totalValue', label: 'Total Value' },
  { key: 'stockStatus', label: 'Stock Status' },
];

export const defaultGroupedStockColumns: StockColumnConfig = {
  product: true,
  genericName: true,
  batchNumber: false, // Hidden in grouped view
  expiryDate: false, // Hidden in grouped view
  location: false, // Hidden in grouped view
  currentQuantityStrips: true,
  currentQuantityDisplay: true,
  costPerStrip: false, // Hidden in grouped view
  totalValue: true,
  stockStatus: true,
  expiryStatus: false, // Hidden in grouped view
};

export type SortField = 'product_name' | 'generic_name' | 'total_quantity_strips' | 'total_value' | 'batch_count';
export type SortDirection = 'asc' | 'desc';

interface GroupedStockTableProps {
  stockData: StockItem[] | undefined;
  isLoading: boolean;
  visibleColumns: Record<string, boolean>;
  onColumnToggle: (columns: Record<string, boolean>) => void;
  sortField: SortField;
  sortDirection: SortDirection;
  onSort: (field: SortField) => void;
  currentPage: number;
  setCurrentPage: (page: number) => void;
  itemsPerPage: number;
}

const GroupedStockTable: React.FC<GroupedStockTableProps> = ({
  stockData,
  isLoading,
  visibleColumns,
  onColumnToggle,
  sortField,
  sortDirection,
  onSort,
  currentPage,
  setCurrentPage,
  itemsPerPage
}) => {
  const [expandedProducts, setExpandedProducts] = useState<Set<string>>(new Set());

  // Fetch packaging units for quantity display conversion
  const { data: packagingUnits } = useQuery({
    queryKey: ['packaging-units'],
    queryFn: async () => {
      const { data, error } = await supabase
        .from('product_packaging_units')
        .select(`
          product_id,
          unit_name,
          conversion_factor_to_strips,
          is_base_unit,
          order_in_hierarchy
        `)
        .order('product_id')
        .order('order_in_hierarchy');
      if (error) throw error;
      return data;
    },
  });

  const toggleProductExpansion = (productId: string) => {
    const newExpanded = new Set(expandedProducts);
    if (newExpanded.has(productId)) {
      newExpanded.delete(productId);
    } else {
      newExpanded.add(productId);
    }
    setExpandedProducts(newExpanded);
  };

  const groupedData = useMemo(() => {
    if (!stockData) return [];

    const grouped = stockData.reduce((acc, item) => {
      const key = item.product_id;
      if (!acc[key]) {
        acc[key] = {
          product_id: item.product_id,
          product_name: item.product_name,
          product_code: item.product_code,
          generic_name: item.generic_name,
          category_name: item.category_name,
          total_quantity_strips: 0,
          total_value: 0,
          batch_count: 0,
          batches: [],
          min_stock_level_godown: item.min_stock_level_godown,
          min_stock_level_mr: item.min_stock_level_mr,
        };
      }
      
      acc[key].total_quantity_strips += item.current_quantity_strips;
      acc[key].total_value += item.total_value;
      acc[key].batch_count += 1;
      acc[key].batches.push(item);
      
      return acc;
    }, {} as Record<string, GroupedStockItem>);

    return Object.values(grouped);
  }, [stockData]);

  const convertStripsToDisplayUnit = (strips: number, productId: string) => {
    if (!packagingUnits) return `${strips} strips`;
    
    const productUnits = packagingUnits
      .filter(unit => unit.product_id === productId)
      .sort((a, b) => b.conversion_factor_to_strips - a.conversion_factor_to_strips);
    
    if (productUnits.length === 0) return `${strips} strips`;
    
    // Find the largest unit that fits
    for (const unit of productUnits) {
      if (strips >= unit.conversion_factor_to_strips) {
        const quantity = Math.floor(strips / unit.conversion_factor_to_strips);
        const remainder = strips % unit.conversion_factor_to_strips;
        
        if (remainder === 0) {
          return `${quantity} ${unit.unit_name}${quantity !== 1 ? 's' : ''}`;
        } else {
          return `${quantity} ${unit.unit_name}${quantity !== 1 ? 's' : ''} + ${remainder} strips`;
        }
      }
    }
    
    return `${strips} strips`;
  };

  const getExpiryStatus = (expiryDate: string) => {
    const expiry = new Date(expiryDate);
    const today = new Date();
    const thirtyDaysFromNow = new Date();
    thirtyDaysFromNow.setDate(today.getDate() + 30);

    if (expiry < today) {
      return { status: 'expired', variant: 'destructive' as const };
    } else if (expiry <= thirtyDaysFromNow) {
      return { status: 'expiring-soon', variant: 'secondary' as const };
    } else {
      return { status: 'good', variant: 'default' as const };
    }
  };

  const getStockStatus = (item: GroupedStockItem | StockItem) => {
    const quantity = 'total_quantity_strips' in item ? item.total_quantity_strips : item.current_quantity_strips;
    const minLevelGodown = item.min_stock_level_godown || 0;
    const minLevelMr = item.min_stock_level_mr || 0;
    const minLevel = Math.max(minLevelGodown, minLevelMr);

    if (quantity <= minLevel) {
      return { status: 'low', variant: 'destructive' as const };
    } else if (quantity <= minLevel * 1.5) {
      return { status: 'medium', variant: 'secondary' as const };
    } else {
      return { status: 'good', variant: 'default' as const };
    }
  };

  const getSortedData = (data: GroupedStockItem[]) => {
    if (!data) return [];
    
    return [...data].sort((a, b) => {
      let compareA, compareB;
      
      switch (sortField) {
        case 'product_name':
          compareA = a.product_name.toLowerCase();
          compareB = b.product_name.toLowerCase();
          break;
        case 'generic_name':
          compareA = (a.generic_name || '').toLowerCase();
          compareB = (b.generic_name || '').toLowerCase();
          break;
        case 'total_quantity_strips':
          compareA = a.total_quantity_strips;
          compareB = b.total_quantity_strips;
          break;
        case 'total_value':
          compareA = a.total_value;
          compareB = b.total_value;
          break;
        case 'batch_count':
          compareA = a.batch_count;
          compareB = b.batch_count;
          break;
        default:
          compareA = a.product_name.toLowerCase();
          compareB = b.product_name.toLowerCase();
      }
      
      const comparison = compareA > compareB ? 1 : compareA < compareB ? -1 : 0;
      return sortDirection === 'asc' ? comparison : -comparison;
    });
  };

  const paginatedData = getSortedData(groupedData).slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  return (
    <Card className="rounded-lg border">
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <div>
          <CardTitle className="text-lg font-semibold">Grouped Stock Details</CardTitle>
          <CardDescription className="text-sm text-gray-600">
            Stock levels grouped by product with expandable batch details
          </CardDescription>
        </div>
        <ProductTableColumns 
          onColumnToggle={onColumnToggle} 
          storageKey="grouped-stock-table-columns"
          columns={GROUPED_STOCK_TABLE_COLUMNS}
        />
      </CardHeader>
      <CardContent>
        <div className="rounded-md border">
          <div className="relative w-full overflow-auto">
            <Table>
              <TableHeader className="bg-muted/50">
                <TableRow className="hover:bg-transparent">
                  <TableHead className="w-[50px]"></TableHead>
                  {visibleColumns.product && (
                    <TableHead 
                      className="w-[250px] text-left text-xs font-medium text-muted-foreground uppercase tracking-wider cursor-pointer"
                      onClick={() => onSort('product_name')}
                    >
                      Product {sortField === 'product_name' && (
                        <span>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </TableHead>
                  )}
                  {visibleColumns.genericName && (
                    <TableHead 
                      className="w-[200px] text-left text-xs font-medium text-muted-foreground uppercase tracking-wider cursor-pointer"
                      onClick={() => onSort('generic_name')}
                    >
                      Generic Name {sortField === 'generic_name' && (
                        <span>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </TableHead>
                  )}
                  <TableHead 
                    className="w-[100px] text-center text-xs font-medium text-muted-foreground uppercase tracking-wider cursor-pointer"
                    onClick={() => onSort('batch_count')}
                  >
                    Batches {sortField === 'batch_count' && (
                      <span>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                    )}
                  </TableHead>
                  {visibleColumns.currentQuantityStrips && (
                    <TableHead 
                      className="w-[120px] text-center text-xs font-medium text-muted-foreground uppercase tracking-wider cursor-pointer"
                      onClick={() => onSort('total_quantity_strips')}
                    >
                      Total Qty (Strips) {sortField === 'total_quantity_strips' && (
                        <span>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </TableHead>
                  )}
                  {visibleColumns.currentQuantityDisplay && (
                    <TableHead className="w-[150px] text-center text-xs font-medium text-muted-foreground uppercase tracking-wider">
                      Total Qty (Display)
                    </TableHead>
                  )}
                  {visibleColumns.totalValue && (
                    <TableHead 
                      className="w-[120px] text-right text-xs font-medium text-muted-foreground uppercase tracking-wider cursor-pointer"
                      onClick={() => onSort('total_value')}
                    >
                      Total Value {sortField === 'total_value' && (
                        <span>{sortDirection === 'asc' ? '↑' : '↓'}</span>
                      )}
                    </TableHead>
                  )}
                  {visibleColumns.stockStatus && (
                    <TableHead className="w-[120px] text-center text-xs font-medium text-muted-foreground uppercase tracking-wider">
                      Stock Status
                    </TableHead>
                  )}
                </TableRow>
              </TableHeader>
              <TableBody>
                {isLoading ? (
                  <TableRow>
                    <TableCell colSpan={7} className="h-24 text-center">
                      <div className="flex flex-col items-center justify-center space-y-2">
                        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>
                        <p className="text-muted-foreground">Loading stock data...</p>
                      </div>
                    </TableCell>
                  </TableRow>
                ) : !groupedData?.length ? (
                  <TableRow>
                    <TableCell colSpan={7} className="h-24 text-center">
                      <div className="flex flex-col items-center justify-center space-y-2">
                        <Package className="h-8 w-8 text-muted-foreground" />
                        <p className="text-muted-foreground">No stock data found for the selected filters</p>
                      </div>
                    </TableCell>
                  </TableRow>
                ) : (
                  paginatedData.map((item) => {
                    const stockStatus = getStockStatus(item);
                    const isExpanded = expandedProducts.has(item.product_id);
                    
                    return (
                      <React.Fragment key={item.product_id}>
                        {/* Main product row */}
                        <TableRow className="hover:bg-muted/50">
                          <TableCell>
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={() => toggleProductExpansion(item.product_id)}
                              className="h-6 w-6 p-0"
                            >
                              {isExpanded ? (
                                <ChevronDown className="h-4 w-4" />
                              ) : (
                                <ChevronRight className="h-4 w-4" />
                              )}
                            </Button>
                          </TableCell>
                          {visibleColumns.product && (
                            <TableCell>
                              <div className="space-y-1">
                                <div className="font-medium">{item.product_code}</div>
                                <div className="text-muted-foreground text-sm">{item.product_name}</div>
                              </div>
                            </TableCell>
                          )}
                          {visibleColumns.genericName && (
                            <TableCell>
                              <span className="text-muted-foreground">{item.generic_name || '-'}</span>
                            </TableCell>
                          )}
                          <TableCell className="text-center">
                            <Badge variant="outline">{item.batch_count}</Badge>
                          </TableCell>
                          {visibleColumns.currentQuantityStrips && (
                            <TableCell className="text-center">
                              <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-sm font-medium ${
                                item.total_quantity_strips <= 0 
                                  ? 'bg-red-100 text-red-800' 
                                  : item.total_quantity_strips <= 10
                                    ? 'bg-yellow-100 text-yellow-800'
                                    : 'bg-green-100 text-green-800'
                              }`}>
                                {item.total_quantity_strips}
                              </span>
                            </TableCell>
                          )}
                          {visibleColumns.currentQuantityDisplay && (
                            <TableCell className="text-center">
                              <span className="font-medium">
                                {convertStripsToDisplayUnit(item.total_quantity_strips, item.product_id)}
                              </span>
                            </TableCell>
                          )}
                          {visibleColumns.totalValue && (
                            <TableCell className="text-right">
                              <span className="font-medium">₹{item.total_value.toFixed(2)}</span>
                            </TableCell>
                          )}
                          {visibleColumns.stockStatus && (
                            <TableCell className="text-center">
                              <Badge variant={stockStatus.variant}>
                                {stockStatus.status === 'low' ? 'Low Stock' : 
                                 stockStatus.status === 'medium' ? 'Medium' : 'Good'}
                              </Badge>
                            </TableCell>
                          )}
                        </TableRow>
                        
                        {/* Expanded batch rows */}
                        {isExpanded && item.batches.map((batch, batchIndex) => {
                          const batchStockStatus = getStockStatus(batch);
                          const batchExpiryStatus = getExpiryStatus(batch.expiry_date);
                          
                          return (
                            <TableRow key={`${item.product_id}-${batchIndex}`} className="bg-muted/25">
                              <TableCell className="pl-8"></TableCell>
                              <TableCell>
                                <div className="text-sm text-muted-foreground pl-4">
                                  Batch: {batch.batch_number}
                                </div>
                              </TableCell>
                              <TableCell>
                                <div className="text-sm text-muted-foreground">
                                  Exp: {new Date(batch.expiry_date).toLocaleDateString()}
                                </div>
                              </TableCell>
                              <TableCell className="text-center">
                                <Badge variant="outline">
                                  {batch.location_type === 'GODOWN' ? 'Godown' : `MR ${batch.location_id || '-'}`}
                                </Badge>
                              </TableCell>
                              <TableCell className="text-center">
                                <span className="text-sm">{batch.current_quantity_strips}</span>
                              </TableCell>
                              <TableCell className="text-center">
                                <span className="text-sm">
                                  {convertStripsToDisplayUnit(batch.current_quantity_strips, batch.product_id)}
                                </span>
                              </TableCell>
                              <TableCell className="text-right">
                                <span className="text-sm">₹{batch.total_value.toFixed(2)}</span>
                              </TableCell>
                              <TableCell className="text-center">
                                <div className="flex gap-1 justify-center">
                                  <Badge variant={batchStockStatus.variant} className="text-xs">
                                    {batchStockStatus.status === 'low' ? 'Low' : 
                                     batchStockStatus.status === 'medium' ? 'Med' : 'Good'}
                                  </Badge>
                                  <Badge variant={batchExpiryStatus.variant} className="text-xs">
                                    {batchExpiryStatus.status === 'expired' ? 'Exp' :
                                     batchExpiryStatus.status === 'expiring-soon' ? 'Soon' : 'Good'}
                                  </Badge>
                                </div>
                              </TableCell>
                            </TableRow>
                          );
                        })}
                      </React.Fragment>
                    );
                  })
                )}
              </TableBody>
            </Table>
          </div>
        </div>
      </CardContent>
      {groupedData?.length > 0 && (
        <CardContent className="flex items-center justify-between px-6 py-4 border-t">
          <div className="text-sm text-muted-foreground">
            Page {currentPage} of {Math.ceil(groupedData.length / itemsPerPage)}
          </div>
          <div className="flex items-center space-x-2">
            <Button
              variant="outline"
              size="sm"
              onClick={() => setCurrentPage(1)}
              disabled={currentPage === 1}
              className="h-8 w-8 p-0"
            >
              <span className="sr-only">Go to first page</span>
              <ChevronsLeft className="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              size="sm"
              onClick={() => setCurrentPage(Math.max(1, currentPage - 1))}
              disabled={currentPage === 1}
              className="h-8 w-8 p-0"
            >
              <span className="sr-only">Go to previous page</span>
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <div className="flex items-center justify-center text-sm font-medium w-8">
              {currentPage}
            </div>
            <Button
              variant="outline"
              size="sm"
              onClick={() => setCurrentPage(Math.min(Math.ceil(groupedData.length / itemsPerPage), currentPage + 1))}
              disabled={currentPage === Math.ceil(groupedData.length / itemsPerPage)}
              className="h-8 w-8 p-0"
            >
              <span className="sr-only">Go to next page</span>
              <ChevronRightIcon className="h-4 w-4" />
            </Button>
            <Button
              variant="outline"
              size="sm"
              onClick={() => setCurrentPage(Math.ceil(groupedData.length / itemsPerPage))}
              disabled={currentPage === Math.ceil(groupedData.length / itemsPerPage)}
              className="h-8 w-8 p-0"
            >
              <span className="sr-only">Go to last page</span>
              <ChevronsRight className="h-4 w-4" />
            </Button>
          </div>
        </CardContent>
      )}
    </Card>
  );
};

export default GroupedStockTable;