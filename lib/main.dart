import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:traffix/l10n/app_localizations.dart';
import 'package:traffix/providers/locale_provider.dart';

// 👇 Screens (all your imports preserved)
import 'package:traffix/screens/admin/adminlogin.dart';
import 'package:traffix/screens/admin/managepolice.dart';
import 'package:traffix/screens/admin/pages/admin_alert_screen.dart';
import 'package:traffix/screens/admin/pages/admin_quiz_upload.dart';
import 'package:traffix/screens/admin/pages/allchallans.dart';
import 'package:traffix/screens/admin/pages/grievance/admin-challan.dart';
import 'package:traffix/screens/admin/pages/grievance/receipt.dart';
import 'package:traffix/screens/admin/pages/incident.dart';
import 'package:traffix/screens/admin/pages/publicnotice.dart';
import 'package:traffix/screens/admin/pages/report.dart';
import 'package:traffix/screens/admin/pages/vehicleapprove.dart';
import 'package:traffix/screens/admin/settingadmin.dart';
import 'package:traffix/screens/police/pages/challancreated.dart';
import 'package:traffix/screens/police/pages/createchallan.dart';
import 'package:traffix/screens/police/pages/towclamp.dart';
import 'package:traffix/screens/police/policeauthscreen.dart';
import 'package:traffix/screens/police/settingpolice.dart';
import 'package:traffix/screens/user/pages/contact.dart';
import 'package:traffix/screens/user/pages/navuser.dart/challan/challandetailscreen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/grievance/grievance_challan_screen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/grievance/grievance_receipt_screen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/grievance/grievanceform.dart';
import 'package:traffix/screens/user/pages/navuser.dart/offensescreen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/public-notices.dart';
import 'package:traffix/screens/user/pages/navuser.dart/report/civilianreport.dart';
import 'package:traffix/screens/user/pages/navuser.dart/challan/myechallan.dart';

import 'package:traffix/screens/splashscreen.dart';
import 'package:traffix/screens/roleselection.dart';
import 'package:traffix/screens/user/authscreen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/myvehicle.dart';
import 'package:traffix/screens/user/pages/navuser.dart/challan/notifcation_screen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/paychallanscreen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/report/incidenthistory.dart';
import 'package:traffix/screens/user/pages/navuser.dart/report/incidentreport.dart';
import 'package:traffix/screens/user/pages/navuser.dart/report/reportviolation.dart';
import 'package:traffix/screens/user/pages/navuser.dart/report/violationhistory.dart';
import 'package:traffix/screens/user/pages/navuser.dart/roadsigns.dart';
import 'package:traffix/screens/user/pages/navuser.dart/trafficalertscreen.dart';
import 'package:traffix/screens/user/pages/navuser.dart/user_quiz_screen.dart';
import 'package:traffix/screens/user/pages/setting.dart';
import 'package:traffix/screens/user/pages/towclam.dart';
import 'package:traffix/screens/user/usersignup.dart';
import 'package:traffix/screens/user/pages/user_home_screen.dart';
import 'package:traffix/screens/police/policescreen.dart';
import 'package:traffix/screens/police/policehome.dart';
import 'package:traffix/screens/police/waitingscreen.dart';
import 'package:traffix/screens/admin/adminhome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://velxsyncclityjsjdjso.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZlbHhzeW5jY2xpdHlqc2pkanNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTIyMjY2NzEsImV4cCI6MjA2NzgwMjY3MX0.aRvTIsmvE2z7McGCapHQBk-o1YRyPAxrfBXQALT-cVg',
  );

  runApp(const ProviderScope(child: TrafficApp()));
}

class TrafficApp extends ConsumerWidget {
  const TrafficApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Traffic360',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      locale: locale, // 👈 this is what makes it dynamic
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('mr')],
      localizationsDelegates: const [
        AppLocalizations.delegate, // 👈 your l10n class
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}

// 🔁 Routing (unchanged)
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
    GoRoute(path: '/role', builder: (_, __) => const RoleSelectionScreen()),

    // 👤 User
    GoRoute(path: '/user/tow', builder: (_, __) => const TowClampUserScreen()),
    GoRoute(path: '/user/auth', builder: (_, __) => const AuthScreen()),
    GoRoute(path: '/user/signup', builder: (_, __) => const UserSignupScreen()),
    GoRoute(path: '/user/home', builder: (_, __) => const UserHomeScreen()),
    GoRoute(path: '/user/contact', builder: (_, __) => const ContactUsScreen()),
    GoRoute(
      path: '/user/challans',
      builder: (_, __) => const ChallanDashboardScreen(),
    ),
    GoRoute(
      path: '/user/challan/:vehicleId',
      builder: (_, state) {
        final vehicleId = state.pathParameters['vehicleId']!;
        return ChallanDetailScreen(vehicleId: vehicleId);
      },
    ),
    GoRoute(
      path: '/user/vehicles',
      builder: (_, __) => const MyVehiclesScreen(),
    ),
    GoRoute(path: '/user/roadsigns', builder: (_, __) => RoadSignsScreen()),
    GoRoute(
      path: '/user/pay-challan',
      builder: (_, __) => const PayChallanScreen(),
    ),
    GoRoute(path: '/user/settings', builder: (_, __) => const SettingsScreen()),
    GoRoute(
      path: '/civilian-report',
      builder: (_, __) => const CivilianReportMenu(),
    ),
    GoRoute(
      path: '/report-violation',
      builder: (_, __) => const ReportViolationDetailScreen(),
    ),
    GoRoute(
      path: '/violation-history',
      builder: (_, __) => const ViolationHistoryScreen(),
    ),
    GoRoute(
      path: '/report-incident',
      builder: (_, __) => const ReportIncidentScreen(),
    ),
    GoRoute(
      path: '/incident-history',
      builder: (_, __) => const IncidentHistoryScreen(),
    ),
    GoRoute(
      path: '/user/grievance',
      builder: (_, __) => const GrievanceScreen(),
    ),
    GoRoute(
      path: '/user/public-notices',
      builder: (_, __) => const PublicNoticeScreen(),
    ),
    GoRoute(
      path: '/user/grievance/receipt',
      builder: (_, __) => const GrievanceReceiptScreen(),
    ),
    GoRoute(
      path: '/user/grievance/challan',
      builder: (_, __) => const GrievanceChallanScreen(),
    ),
    GoRoute(path: '/offenses', builder: (_, __) => const OffenseScreen()),
    GoRoute(
      path: '/alerts',
      builder: (_, __) => const UserTrafficAlertScreen(),
    ),
    GoRoute(
      path: '/user/quiz',
      name: 'user_quiz',
      builder: (_, __) => const UserQuizScreen(),
    ),

    // 👮 Police
    GoRoute(
      path: '/police/signup',
      builder: (_, __) => const PoliceSignupScreen(),
    ),
    GoRoute(
      path: '/police/waiting',
      builder: (_, __) => const PoliceWaitingScreen(),
    ),
    GoRoute(
      path: '/police/home',
      builder: (_, __) => const PoliceHomeDashboard(),
    ),
    GoRoute(
      path: '/police/create-challan',
      builder: (_, __) => const CreateChallanScreen(),
    ),
    GoRoute(
      path: '/notifications',
      builder: (_, __) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/police/all-challans',
      builder: (_, __) => const PoliceChallansScreen(),
    ),
    GoRoute(path: '/police/auth', builder: (_, __) => const PoliceAuthScreen()),
    GoRoute(
      path: '/police/tow-clamp',
      builder: (_, __) => const TowClampPage(),
    ),
    GoRoute(
      path: '/police/settings',
      builder: (context, state) => const PoliceSettingsScreen(),
    ),

    // 🛡️ Admin
    GoRoute(path: '/admin/login', builder: (_, __) => const AdminLoginScreen()),
    GoRoute(path: '/admin/home', builder: (_, __) => const AdminHomeScreen()),
    GoRoute(
      path: '/admin/vehicles',
      builder: (_, __) => const AdminVehicleApprovalScreen(),
    ),
    GoRoute(
      path: '/admin/notices',
      builder: (_, __) => const AdminNoticeScreen(),
    ),
    GoRoute(
      path: '/admin/quiz-upload',
      builder: (_, __) => const AdminQuizUploadScreen(),
    ),
    GoRoute(path: '/admin/alert', builder: (_, __) => const AdminAlertScreen()),
    GoRoute(
      path: '/admin/managepolice',
      builder: (_, __) => const AdminManagePoliceScreen(),
    ),
    GoRoute(
      path: '/admin/incidents',
      builder: (_, __) => const AdminIncidentScreen(),
    ),
    GoRoute(
      path: '/admin/report',
      builder: (_, __) => const AdminViolationScreen(),
    ),
    GoRoute(
      path: '/admin/greivance-challan',
      builder: (_, __) => const AdminGrievanceChallanScreen(),
    ),
    GoRoute(
      path: '/admin/greivance-receipt',
      builder: (_, __) => const AdminGrievanceReceiptScreen(),
    ),
    GoRoute(
      path: '/admin/challans',
      builder: (_, __) => const AdminAllChallansScreen(),
    ),
    GoRoute(
      path: '/admin/settings',
      builder: (context, state) => const AdminSettingsScreen(),
    ),
  ],
);
