import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:traffix/l10n/app_localizations.dart'; // 👈 Add this for localization

/// 🎨 Shared palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kTextSecondary = Color(0xFF555555);
const kCardBackground = Color(0xFFFFFFFF);

final storage = FlutterSecureStorage();

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Future<void> _selectRoleAndGo(BuildContext context, String role) async {
    await storage.write(key: 'selected_role', value: role);

    if (role == 'admin') {
      context.go('/admin/login');
    } else if (role == 'user') {
      context.go('/user/auth');
    } else if (role == 'police') {
      context.go('/police/auth');
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 👈 localization instance

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                loc.roleTitle, // 👈 localized string
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              const SizedBox(height: 40),

              /// 👤 User
              RoleButton(
                icon: Icons.person,
                title: loc.user, // 👈 localized string
                color: kPrimary,
                onTap: () => _selectRoleAndGo(context, 'user'),
              ),
              const SizedBox(height: 20),

              /// 🚓 Police
              RoleButton(
                icon: Icons.local_police,
                title: loc.police, // 👈 localized string
                color: Colors.deepOrange,
                onTap: () => _selectRoleAndGo(context, 'police'),
              ),
              const SizedBox(height: 20),

              /// 🛡️ Admin
              RoleButton(
                icon: Icons.admin_panel_settings,
                title: loc.admin, // 👈 localized string
                color: Colors.teal,
                onTap: () => _selectRoleAndGo(context, 'admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const RoleButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = kPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCardBackground,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.4), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: kTextSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
