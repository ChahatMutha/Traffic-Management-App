import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

final supabase = Supabase.instance.client;

class AdminVehicleApprovalScreen extends StatefulWidget {
  const AdminVehicleApprovalScreen({super.key});

  @override
  State<AdminVehicleApprovalScreen> createState() =>
      _AdminVehicleApprovalScreenState();
}

class _AdminVehicleApprovalScreenState
    extends State<AdminVehicleApprovalScreen> {
  late Future<List<Map<String, dynamic>>> _vehiclesFuture;
  String _filter = 'pending';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _vehiclesFuture = fetchAllVehicles();
  }

  Future<List<Map<String, dynamic>>> fetchAllVehicles() async {
    final response = await supabase
        .from('vehicles')
        .select(
          'id, vehicle_number, vehicle_type, rc_doc_url, is_verified, created_at, people(full_name)',
        )
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> updateVehicleStatus(String id, bool? isVerified) async {
    await supabase
        .from('vehicles')
        .update({'is_verified': isVerified})
        .eq('id', id);
    setState(() {
      _vehiclesFuture = fetchAllVehicles();
    });
  }

  Future<void> launchRC(String rcPath) async {
    try {
      if (rcPath.isEmpty) throw 'RC path is empty';

      final response = await supabase.storage
          .from('rc-docs')
          .createSignedUrl(rcPath, 60 * 5);
      final uri = Uri.parse(response);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch RC document');
      }
    } catch (e) {
      debugPrint('❌ RC Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open RC document')),
        );
      }
    }
  }

  Widget buildVehicleCard(Map<String, dynamic> vehicle) {
    final id = vehicle['id'];
    final vehicleNumber = vehicle['vehicle_number'] ?? 'N/A';
    final vehicleType = vehicle['vehicle_type'] ?? 'N/A';
    final ownerName = vehicle['people']?['full_name'] ?? 'N/A';
    final createdAt = vehicle['created_at']?.toString().split('T').first ?? '';
    final rcDocPath = vehicle['rc_doc_url'] as String?;
    final isVerified = vehicle['is_verified'];

    if (_filter == 'pending' && isVerified != null) return const SizedBox();
    if (_filter == 'approved' && isVerified != true) return const SizedBox();
    if (_filter == 'rejected' && isVerified != false) return const SizedBox();

    if (_searchQuery.isNotEmpty) {
      final combined = '$vehicleNumber $vehicleType $ownerName'.toLowerCase();
      if (!combined.contains(_searchQuery.toLowerCase())) {
        return const SizedBox();
      }
    }

    return Card(
      color: kCardBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vehicle Number: $vehicleNumber",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Owner: $ownerName",
              style: const TextStyle(color: kTextSecondary),
            ),
            Text(
              "Type: $vehicleType",
              style: const TextStyle(color: kTextSecondary),
            ),
            Text(
              "Added On: $createdAt",
              style: const TextStyle(color: kTextSecondary),
            ),
            const SizedBox(height: 10),
            if (rcDocPath != null && rcDocPath.isNotEmpty)
              TextButton.icon(
                icon: const Icon(Icons.picture_as_pdf, color: kPrimary),
                label: const Text(
                  "View RC Document",
                  style: TextStyle(color: kPrimary),
                ),
                onPressed: () => launchRC(rcDocPath),
              ),
            if (_filter == 'pending') ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text("Approve"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => updateVehicleStatus(id, true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.close),
                      label: const Text("Reject"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => updateVehicleStatus(id, false),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilterChip(
            label: Text(
              "Pending",
              style: TextStyle(
                color: _filter == 'pending' ? Colors.white : kTextPrimary,
              ),
            ),
            selected: _filter == 'pending',
            onSelected: (_) => setState(() => _filter = 'pending'),
            selectedColor: kPrimary,
            backgroundColor: kCardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FilterChip(
            label: Text(
              "Approved",
              style: TextStyle(
                color: _filter == 'approved' ? Colors.white : kTextPrimary,
              ),
            ),
            selected: _filter == 'approved',
            onSelected: (_) => setState(() => _filter = 'approved'),
            selectedColor: kPrimary,
            backgroundColor: kCardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FilterChip(
            label: Text(
              "Rejected",
              style: TextStyle(
                color: _filter == 'rejected' ? Colors.white : kTextPrimary,
              ),
            ),
            selected: _filter == 'rejected',
            onSelected: (_) => setState(() => _filter = 'rejected'),
            selectedColor: kPrimary,
            backgroundColor: kCardBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          "Vehicle Approvals",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/admin/home'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search vehicle or owner',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          const SizedBox(height: 12),
          buildFilterButtons(),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _vehiclesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final vehicles = snapshot.data ?? [];
                if (vehicles.isEmpty) {
                  return const Center(child: Text('No vehicles found.'));
                }
                return ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return buildVehicleCard(vehicles[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
