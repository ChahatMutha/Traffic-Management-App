import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 🎨 Color Palette
const kBackground = Color(0xFFEEEEEE);
const kPrimary = Color(0xFF171476);
const kTextPrimary = Color(0xFF060606);
const kCardBackground = Color(0xFFFFFFFF);

class RoadSign {
  final String label;
  final String assetPath;

  RoadSign(this.label, this.assetPath);
}

class RoadSignsScreen extends StatelessWidget {
  RoadSignsScreen({Key? key}) : super(key: key);

  final List<RoadSign> signs = [
    RoadSign("Stop", "assets/images/stop.png"),
    RoadSign("No Entry", "assets/images/no-entry.png"),
    RoadSign("U Turn Prohibited", "assets/images/no-u-turn.png"),
    RoadSign("Overtaking Prohibited", "assets/images/no-overtaking.png"),
    RoadSign("Speed Limit", "assets/images/speed-limit.png"),
    RoadSign("Right Hand Curve", "assets/images/right-hand-curve.jpeg"),
    RoadSign("Pedestrian Crossing", "assets/images/pedestrian-crossing.png"),
    RoadSign("School Ahead", "assets/images/school-ahead.jpeg"),
    RoadSign("Right Turn Prohibited", "assets/images/no-turn-right.png"),
    RoadSign("Slippery Road", "assets/images/slippery-road.png"),
    RoadSign("Y - Intersection", "assets/images/y-intersection.jpeg"),
    RoadSign("Narrow Bridge Ahead", "assets/images/narrow_bridge.png"),
    RoadSign("Left Hand Curve", "assets/images/lefthandcurve.jpeg"),
    RoadSign("Railway Crossing", "assets/images/railway_crossing.jpeg"),
    RoadSign("Roundabout", "assets/images/roundabout.jpeg"),
    RoadSign("No Horn", "assets/images/nohorn.jpeg"),
    RoadSign("Cattle Crossing", "assets/images/cattlecrossing.jpeg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/user/home'),
        ),
        title: const Text(
          "Road Signs",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // ✅ Bold title
            fontSize: 20,
          ),
        ),
        elevation: 2,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9, // slightly adjusted
        ),
        itemCount: signs.length,
        itemBuilder: (context, index) {
          final sign = signs[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ✅ Image container
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kCardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(sign.assetPath, fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // ✅ Fixed height for text area
              SizedBox(
                height: 34, // fixed height for label area
                child: Center(
                  child: Text(
                    sign.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: kTextPrimary,
                    ),
                    maxLines: 2, // allow 2 lines
                    overflow: TextOverflow.ellipsis,
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
