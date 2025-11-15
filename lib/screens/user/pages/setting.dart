// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:traffix/l10n/app_localizations.dart';
// import '../../../main.dart'; // ✅ to access localeProvider

// class SettingsScreen extends ConsumerWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final loc = AppLocalizations.of(context)!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(loc.settings),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => context.go('/user/home'),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const SizedBox(height: 10),

//           // ✅ Profile
//           ListTile(
//             leading: const Icon(Icons.person, color: Colors.indigo),
//             title: Text(loc.profile),
//             subtitle: Text(loc.viewOrEditProfile),
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(loc.profileTapped)));
//             },
//           ),
//           const Divider(),

//           // 🌍 Language Selection
//           ListTile(
//             leading: const Icon(Icons.language, color: Colors.indigo),
//             title: Text(loc.language),
//             subtitle: Text(loc.changeLanguage),
//             onTap: () async {
//               final selectedLocale = await showDialog<Locale>(
//                 context: context,
//                 builder: (context) {
//                   return SimpleDialog(
//                     title: Text(loc.chooseLanguage),
//                     children: [
//                       SimpleDialogOption(
//                         onPressed: () =>
//                             Navigator.pop(context, const Locale('en')),
//                         child: const Text('English'),
//                       ),
//                       SimpleDialogOption(
//                         onPressed: () =>
//                             Navigator.pop(context, const Locale('hi')),
//                         child: const Text('हिन्दी'),
//                       ),
//                       SimpleDialogOption(
//                         onPressed: () =>
//                             Navigator.pop(context, const Locale('mr')),
//                         child: const Text('मराठी'),
//                       ),
//                     ],
//                   );
//                 },
//               );

//               if (selectedLocale != null) {
//                 // ✅ Update the Riverpod provider so app rebuilds with new locale
//                await ref.read(localeProvider.notifier).setLocale(selectedLocale);
//               }
//             },
//           ),
//           const Divider(),

//           // 🔔 Notifications
//           SwitchListTile(
//             secondary: const Icon(Icons.notifications, color: Colors.indigo),
//             title: Text(loc.notifications),
//             subtitle: Text(loc.enableOrDisableNotifications),
//             value: true,
//             onChanged: (value) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     '${loc.notifications}: ${value ? loc.on : loc.off}',
//                   ),
//                 ),
//               );
//             },
//           ),
//           const Divider(),

//           // 🌙 Dark Mode
//           SwitchListTile(
//             secondary: const Icon(Icons.dark_mode, color: Colors.indigo),
//             title: Text(loc.darkMode),
//             subtitle: Text(loc.toggleDarkTheme),
//             value: false,
//             onChanged: (value) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('${loc.darkMode}: ${value ? loc.on : loc.off}'),
//                 ),
//               );
//             },
//           ),
//           const Divider(),

//           // 🚪 Logout
//           ListTile(
//             leading: const Icon(Icons.logout, color: Colors.red),
//             title: Text(loc.logout),
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(loc.logoutTapped)));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _logout(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    context.go('/role'); // Navigate to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF171476), // kPrimary
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFEEEEEE), // kBackground
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _logout(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
