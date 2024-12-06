import 'package:flutter/material.dart';
import 'package:portfolio_web/Responsive/Desktop_HomePage.dart';
import 'package:portfolio_web/Responsive/Mobile_HomePage.dart';
import 'package:portfolio_web/Responsive/Tablet_HomePage.dart';
import 'package:portfolio_web/Responsive_Layout.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
      return const ResponsiveLayout(
      mobileBody: MobileHomepage(),
      tabletBody: TabletHomepage(),
      desktopBody: DesktopHomepage(),
    );
  }
}