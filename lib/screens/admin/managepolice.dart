import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

/// === Color Palette ===
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

final supabase = Supabase.instance.client;

class AdminManagePoliceScreen extends StatefulWidget {
  const AdminManagePoliceScreen({super.key});

  @override
  State<AdminManagePoliceScreen> createState() =>
      _AdminManagePoliceScreenState();
}

class _AdminManagePoliceScreenState extends State<AdminManagePoliceScreen> {
  late Future<List<Map<String, dynamic>>> _policeFuture;
  String _filter = 'pending';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _policeFuture = fetchPoliceList();
  }

  Future<List<Map<String, dynamic>>> fetchPoliceList() async {
    final response = await supabase
        .from('police')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> updateApprovalStatus(String poid, bool? status) async {
    await supabase.from('police').update({'approved': status}).eq('poid', poid);
    setState(() {
      _policeFuture = fetchPoliceList();
    });
  }

  Widget buildPoliceCard(Map<String, dynamic> officer) {
    final poid = officer['poid'];
    final station = officer['station_code'] ?? 'N/A';
    final region = officer['region'] ?? 'N/A';
    final policeId = officer['police_id'] ?? 'N/A';
    final createdAt = officer['created_at']?.toString().split('T').first ?? '';
    final approved = officer['approved'];

    if (_filter == 'pending' && approved != null) return const SizedBox();
    if (_filter == 'approved' && approved != true) return const SizedBox();
    if (_filter == 'rejected' && approved != false) return const SizedBox();

    if (_searchQuery.isNotEmpty) {
      final combined = '$station $region $policeId'.toLowerCase();
      if (!combined.contains(_searchQuery.toLowerCase())) {
        return const SizedBox();
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: kCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Police ID: $policeId",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Station: $station",
              style: const TextStyle(color: kTextSecondary),
            ),
            Text(
              "Region: $region",
              style: const TextStyle(color: kTextSecondary),
            ),
            Text(
              "Applied On: $createdAt",
              style: const TextStyle(color: kTextSecondary),
            ),
            const SizedBox(height: 8),
            if (_filter == 'pending')
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => updateApprovalStatus(poid, true),

                    label: const Text("Approve"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => updateApprovalStatus(poid, false),
                    icon: const Icon(Icons.close),
                    label: const Text("Reject"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            if (_filter != 'pending')
              Text(
                "Status: ${approved == true ? 'Approved' : 'Rejected'}",
                style: TextStyle(
                  color: approved == true ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 10,
        children: [
          ChoiceChip(
            label: const Text('Pending'),
            selected: _filter == 'pending',
            selectedColor: kPrimary,
            backgroundColor: Colors.grey.shade300,
            labelStyle: TextStyle(
              color: _filter == 'pending' ? Colors.white : kTextPrimary,
              fontWeight: FontWeight.w500,
            ),
            onSelected: (_) => setState(() => _filter = 'pending'),
          ),
          ChoiceChip(
            label: const Text('Approved'),
            selected: _filter == 'approved',
            selectedColor: kPrimary,
            backgroundColor: Colors.grey.shade300,
            labelStyle: TextStyle(
              color: _filter == 'approved' ? Colors.white : kTextPrimary,
              fontWeight: FontWeight.w500,
            ),
            onSelected: (_) => setState(() => _filter = 'approved'),
          ),
          ChoiceChip(
            label: const Text('Rejected'),
            selected: _filter == 'rejected',
            selectedColor: kPrimary,
            backgroundColor: Colors.grey.shade300,
            labelStyle: TextStyle(
              color: _filter == 'rejected' ? Colors.white : kTextPrimary,
              fontWeight: FontWeight.w500,
            ),
            onSelected: (_) => setState(() => _filter = 'rejected'),
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
        title: const Text("Manage Police Officers"),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/admin/home'),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by ID, station, or region',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(color: kTextSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          const SizedBox(height: 8),
          buildFilterButtons(),
          const SizedBox(height: 8),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _policeFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final officers = snapshot.data ?? [];
                if (officers.isEmpty) {
                  return const Center(
                    child: Text(
                      'No police officers found.',
                      style: TextStyle(color: kTextSecondary),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: officers.length,
                  itemBuilder: (context, index) {
                    return buildPoliceCard(officers[index]);
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
