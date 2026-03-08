import 'package:flutter/material.dart';
import '../widgets/custom_bottom_navbar.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Overview Screen")),
      bottomNavigationBar: const CustomBottomNavbar(pageRoute: "/overview"),
    );
  }
}