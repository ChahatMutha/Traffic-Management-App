import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// 🔐 Providers
final authProvider = Provider((ref) => Supabase.instance.client.auth);
final supabaseProvider = Provider((ref) => Supabase.instance.client);
final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

/// 🧠 Fetch police profile using `poid`
final policeProfileProvider = FutureProvider((ref) async {
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) throw Exception("User not logged in");

  final response = await Supabase.instance.client
      .from('police')
      .select()
      .eq('poid', userId)
      .single();

  return response;
});

/// 👮 Police Settings Screen
class PoliceSettingsScreen extends ConsumerWidget {
  const PoliceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);
    final storage = ref.read(secureStorageProvider);
    final profileAsync = ref.watch(policeProfileProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          "Police Settings",
          style: TextStyle(color: kTextPrimary),
        ),
        backgroundColor: kBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: kTextPrimary),
      ),
      body: profileAsync.when(
        data: (profile) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildProfileCard(profile),
              const SizedBox(height: 16),
              _buildActionCard(
                icon: Icons.edit,
                title: "Edit Profile",
                subtitle: "Update your profile details",
                onTap: () => context.push('/police/edit-profile'),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                icon: Icons.logout,
                title: "Logout",
                subtitle: "Sign out and return to role selection",
                onTap: () async {
                  await auth.signOut();
                  await storage.delete(key: 'role');
                  context.go('/role');
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return Card(
      color: kCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profile Info",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _profileField("Police ID", profile['police_id'] ?? ''),
            _profileField("Station Code", profile['station_code'] ?? ''),
            _profileField("Resigned", profile['resign'] == true ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _profileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: kTextPrimary,
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: kTextSecondary)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: kCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: kPrimary),
        title: Text(title, style: const TextStyle(color: kTextPrimary)),
        subtitle: Text(subtitle, style: const TextStyle(color: kTextSecondary)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: kTextSecondary,
        ),
        onTap: onTap,
      ),
    );
  }
}
