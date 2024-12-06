import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final String heroTag;
  final bool isDarkMode;

  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.heroTag,
    required this.isDarkMode,
  });

  // Show contact dialog
  void _showContactDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Contact",
      pageBuilder: (context, _, __) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80, vertical: 24),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 300,
              height: 190,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isDarkMode
                    ? const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 10, 20, 40),
                          Color.fromARGB(255, 4, 63, 134),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 34, 113, 241),
                          Color.fromARGB(255, 169, 216, 255),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Hire Me",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        const link = "https://wa.me/923442425726";
                        launchUrl(Uri.parse(link),
                            mode: LaunchMode.inAppBrowserView);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "WhatsApp",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        const link =
                            "https://www.upwork.com/freelancers/~01e5a488c532df3fad?mp_source=share";
                        launchUrl(Uri.parse(link),
                            mode: LaunchMode.inAppBrowserView);
                      },
                      icon: const Icon(
                        FontAwesomeIcons.upwork,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Upwork",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      transitionBuilder: (context, anim, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: anim,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () => _showContactDialog(context),
            child: Container(
              height: 220,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  AutoSizeText(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  AutoSizeText(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  icon == 'mobile'
                      ? FontAwesomeIcons.mobile
                      : icon == 'pencil'
                          ? FontAwesomeIcons.pencil
                          : FontAwesomeIcons.cloud,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
