import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

/// 🎨 Colors
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

/// ✅ Admin Auth Check from `admins` Table
final adminProfileProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final supabase = Supabase.instance.client;
  final user = supabase.auth.currentUser;

  if (user == null) throw Exception('Not logged in');

  // Check if the user is in the `admins` table
  final response = await supabase
      .from('admins')
      .select()
      .eq('aid', user.id)
      .maybeSingle();

  if (response == null) throw Exception('Admin record not found');

  // Return only the email from `auth.users`
  return {
    'email': user.email ?? 'No email',
  };
});

/// ⚙️ Admin Settings Screen
class AdminSettingsScreen extends ConsumerWidget {
  const AdminSettingsScreen({super.key});

  void _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    context.go('/role'); // Redirect to role selection screen
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminProfile = ref.watch(adminProfileProvider);

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text(
          'Admin Settings',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: adminProfile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: ${err.toString()}')),
        data: (data) {
          final email = data['email'] ?? 'N/A';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: kCardBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: const Text('Email'),
                  subtitle: Text(email),
                  leading: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}