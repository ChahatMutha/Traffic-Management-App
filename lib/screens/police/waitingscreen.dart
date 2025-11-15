import 'package:flutter/material.dart';
import 'package:traffix/screens/user/pages/navuser.dart/grievance/grievanceform.dart';

class PoliceWaitingScreen extends StatelessWidget {
  const PoliceWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hourglass_empty, size: 80, color: kPrimary),
              SizedBox(height: 20),
              Text(
                'Awaiting Approval',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Your account is pending approval by the admin.\nPlease check back later.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
