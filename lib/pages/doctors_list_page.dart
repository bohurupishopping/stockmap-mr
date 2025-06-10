import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/doctor/doctor_cubit.dart';
import '../bloc/doctor/doctor_state.dart';
import '../models/doctor_models.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({super.key});

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().loadDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'My Doctors',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchSection(),
          Expanded(
            child: BlocBuilder<DoctorCubit, DoctorState>(
              builder: (context, state) {
                if (state is DoctorInitial || state is DoctorLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DoctorLoaded) {
                  return _buildDoctorsList(state.doctors);
                } else if (state is DoctorError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(
                  child: Text('Loading doctors...'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new doctor functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add new doctor feature coming soon!'),
            ),
          );
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search doctors by name...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    context.read<DoctorCubit>().clearSearch();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue[700]!),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        onChanged: (query) {
          setState(() {}); // Update UI for clear button
          context.read<DoctorCubit>().searchDoctors(query);
        },
      ),
    );
  }

  Widget _buildDoctorsList(List<Doctor> doctors) {
    if (doctors.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_search,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No doctors found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try adjusting your search or check back later',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<DoctorCubit>().loadDoctors(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return _DoctorCard(
            doctor: doctor,
            onTap: () => context.push('/doctors/${doctor.id}'),
          );
        },
      ),
    );
  }

}

class _DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const _DoctorCard({
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildTierIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (doctor.specialty != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        doctor.specialty!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                    if (doctor.clinicAddress != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        doctor.clinicAddress!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTierIcon() {
    Color tierColor;
    String tierLabel;
    
    switch (doctor.tier) {
      case DoctorTier.a:
        tierColor = Colors.green;
        tierLabel = 'A';
        break;
      case DoctorTier.b:
        tierColor = Colors.orange;
        tierLabel = 'B';
        break;
      case DoctorTier.c:
        tierColor = Colors.red;
        tierLabel = 'C';
        break;
      default:
        tierColor = Colors.grey;
        tierLabel = '?';
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: tierColor.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: tierColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          tierLabel,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: tierColor,
          ),
        ),
      ),
    );
  }
}