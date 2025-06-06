import 'package:flutter/material.dart';

class CustomerSection extends StatelessWidget {
  final String customerName;
  final String notes;
  final Function(String) onCustomerNameChanged;
  final Function(String) onNotesChanged;
  final String? customerNameError;

  const CustomerSection({
    super.key,
    required this.customerName,
    required this.notes,
    required this.onCustomerNameChanged,
    required this.onNotesChanged,
    this.customerNameError,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modern Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366f1),
                  const Color(0xFF8b5cf6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366f1).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer Information',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Enter customer details for this order',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Customer Name Field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.business_rounded,
                          color: Color(0xFF6366f1),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Customer Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1f2937),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Required',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: customerName,
                    onChanged: onCustomerNameChanged,
                    decoration: InputDecoration(
                      hintText: 'e.g., Dr. Sharma\'s Clinic',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.store_rounded,
                          color: Color(0xFF6366f1),
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: customerNameError != null 
                              ? Colors.red.withValues(alpha: 0.3)
                              : Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: customerNameError != null 
                              ? Colors.red 
                              : const Color(0xFF6366f1),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      errorText: customerNameError,
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textCapitalization: TextCapitalization.words,
                    maxLength: 100,
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          '$currentLength/${maxLength ?? 0}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366f1).withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF6366f1).withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366f1).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFF6366f1),
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Enter the name of the clinic, pharmacy, or customer you\'re selling to.',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF6366f1).withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Notes Field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10b981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.note_alt_rounded,
                          color: Color(0xFF10b981),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1f2937),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10b981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Optional',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF10b981),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: notes,
                    onChanged: onNotesChanged,
                    decoration: InputDecoration(
                      hintText: 'Add any special instructions or notes about this order...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                      ),
                      prefixIcon: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10b981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF10b981),
                          size: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Color(0xFF10b981),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 4,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                      return Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          '$currentLength/${maxLength ?? 0}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10b981).withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF10b981).withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10b981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.lightbulb_outline_rounded,
                            color: Color(0xFF10b981),
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'You can add delivery instructions, payment terms, or any other relevant information.',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF10b981).withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Quick Customer Templates (Optional Enhancement)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3b82f6).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.speed_rounded,
                          color: Color(0xFF3b82f6),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Quick Select',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1f2937),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Common customer names:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _QuickSelectChip(
                        label: 'Dr. Sharma\'s Clinic',
                        onTap: () => onCustomerNameChanged('Dr. Sharma\'s Clinic'),
                      ),
                      _QuickSelectChip(
                        label: 'City Medical Store',
                        onTap: () => onCustomerNameChanged('City Medical Store'),
                      ),
                      _QuickSelectChip(
                        label: 'Apollo Pharmacy',
                        onTap: () => onCustomerNameChanged('Apollo Pharmacy'),
                      ),
                      _QuickSelectChip(
                        label: 'Health Plus Clinic',
                        onTap: () => onCustomerNameChanged('Health Plus Clinic'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickSelectChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickSelectChip({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF3b82f6).withValues(alpha: 0.1),
                const Color(0xFF3b82f6).withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: const Color(0xFF3b82f6).withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3b82f6).withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFF3b82f6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 14,
                  color: Color(0xFF3b82f6),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3b82f6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}