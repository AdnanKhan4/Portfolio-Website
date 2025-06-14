import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portfolio_web/env_config.dart';
import 'package:portfolio_web/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DesktopHomepage extends StatefulWidget {
  const DesktopHomepage({super.key});

  @override
  State<DesktopHomepage> createState() => _DesktopHomepageState();
}

class _DesktopHomepageState extends State<DesktopHomepage>
    with SingleTickerProviderStateMixin {
  bool isDarkMode = false;

  // Toggle dark mode
  void toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  final GlobalKey _homeSectionKey = GlobalKey();
  final GlobalKey _aboutSectionKey = GlobalKey();
  final GlobalKey _skillsSectionKey = GlobalKey();
  final GlobalKey _projectsSectionKey = GlobalKey();
  final GlobalKey _servicesSectionKey = GlobalKey();
  final GlobalKey _contactSectionKey = GlobalKey();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  //Slide Animation of Welcome Text
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetAnimation2;
  late Animation<Offset> _offsetAnimation3;
  late Animation<Offset> _offsetAnimation4;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation3 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation4 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to send the email
  Future<void> sendEmail(
      BuildContext context, String name, String email, String message) async {


    //URL for the EmailJS API
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final headers = {'Content-Type': 'application/json'};

    //body for the email
    final body = jsonEncode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'from_name': name,
        'from_email': email,
        'message': message,
      },
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 16),
                Text('Success', style: TextStyle(color: Colors.green)),
              ],
            ),
            content: const Text('Your message was sent successfully!'),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error, color: Colors.red, size: 60),
                SizedBox(height: 16),
                Text('Error', style: TextStyle(color: Colors.red)),
              ],
            ),
            content: const Text(
                'Failed to send your message. Please try again later.'),
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  final ScrollController _scrollController = ScrollController();

  // Function to scroll to the top
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  final double _elevation1 = 5;
  final double _scale1 = 1;

  final double _elevation2 = 5;
  final double _scale2 = 1;

  void scrollToHomeSection() {
    Scrollable.ensureVisible(
      _homeSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  void scrollToAboutSection() {
    Scrollable.ensureVisible(
      _aboutSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  void scrollToSkillsSection() {
    Scrollable.ensureVisible(
      _skillsSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  void scrollToProjectsSection() {
    Scrollable.ensureVisible(
      _projectsSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  void scrollToServicesSection() {
    Scrollable.ensureVisible(
      _servicesSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  void scrollToContactSection() {
    Scrollable.ensureVisible(
      _contactSectionKey.currentContext!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  final List<Map<String, dynamic>> skills = [
    {
      'name': 'Flutter UI',
      'percentage': 0.6,
      'description': 'Material Design Principles, Responsive Design'
    },
    {
      'name': 'API Integration',
      'percentage': 0.75,
      'description': 'Rest/Restful API\'s'
    },
    {'name': 'State Management', 'percentage': 0.45, 'description': 'Provider'},
    {
      'name': 'Database Management',
      'percentage': 0.6,
      'description': 'Firebase,SqfLite'
    },
    {
      'name': 'Firebase Integration',
      'percentage': 0.5,
      'description': 'Firebase, Cloud Firestore'
    },
    {
      'name': 'UI/UX Designing',
      'percentage': 0.4,
      'description': 'Figma, UI Design, UX Design'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 34, 113, 241),
                    Color.fromARGB(255, 169, 216, 255),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 10, 20, 40),
                    Color.fromARGB(255, 4, 63, 134),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: Column(
          children: [
// Sticky Navbar
            Container(
              color: Colors.transparent,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AutoSizeText(
                      'Portfolio.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToHomeSection,
                            child: const AutoSizeText(
                              'Home',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToAboutSection,
                            child: const AutoSizeText(
                              'About',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToSkillsSection,
                            child: const AutoSizeText(
                              'Skills',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToProjectsSection,
                            child: const AutoSizeText(
                              'Projects',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToServicesSection,
                            child: const AutoSizeText(
                              'Services',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: TextButton(
                            onPressed: scrollToContactSection,
                            child: const AutoSizeText(
                              'Contact',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        Switch(
                          value: isDarkMode,
                          onChanged: toggleDarkMode,
                          activeColor: Colors.white,
                          inactiveTrackColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                automaticallyImplyLeading: false,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Full-Screen Welcome Section
                    Container(
                      key: _homeSectionKey,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(horizontal: 140.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SlideTransition(
                                    position: _offsetAnimation,
                                    child: const AutoSizeText(
                                      'WELCOME TO MY PORTFOLIO! 👋',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SlideTransition(
                                    position: _offsetAnimation2,
                                    child: const Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Adnan\n',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 70,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Khan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 70,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      style: TextStyle(height: 1.2),
                                    ),
                                  ),
                                  SlideTransition(
                                    position: _offsetAnimation3,
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          ValueNotifier<bool>(isDarkMode),
                                      builder: (context, value, child) {
                                        return AnimatedTextKit(
                                          repeatForever: true,
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              'a Flutter Developer',
                                              textStyle: TextStyle(
                                                color: value
                                                    ? Colors.white
                                                    : Colors.grey,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              speed: const Duration(
                                                  milliseconds: 50),
                                            ),
                                            TyperAnimatedText(
                                              'a Friend',
                                              textStyle: TextStyle(
                                                color: value
                                                    ? Colors.white
                                                    : Colors.grey,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              speed: const Duration(
                                                  milliseconds: 50),
                                            ),
                                            TyperAnimatedText(
                                              'a Student',
                                              textStyle: TextStyle(
                                                color: value
                                                    ? Colors.white
                                                    : Colors.grey,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              speed: const Duration(
                                                  milliseconds: 50),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SlideTransition(
                                    position: _offsetAnimation4,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              FontAwesomeIcons.instagram),
                                          color: Colors.white,
                                          iconSize: 30,
                                          onPressed: () {
                                            const link =
                                                "https://www.instagram.com/__adnankhan._";
                                            launchUrl(Uri.parse(link),
                                                mode: LaunchMode
                                                    .inAppBrowserView);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              FontAwesomeIcons.linkedin),
                                          color: Colors.white,
                                          iconSize: 30,
                                          onPressed: () {
                                            const link =
                                                "https://www.linkedin.com/in/adnan-khan-5611981ba/";
                                            launchUrl(Uri.parse(link),
                                                mode: LaunchMode
                                                    .inAppBrowserView);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              FontAwesomeIcons.github),
                                          color: Colors.white,
                                          iconSize: 30,
                                          onPressed: () {
                                            const link =
                                                "https://github.com/AdnanKhan4";
                                            launchUrl(Uri.parse(link),
                                                mode: LaunchMode
                                                    .inAppBrowserView);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.facebook),
                                          color: Colors.white,
                                          iconSize: 30,
                                          onPressed: () {
                                            const link =
                                                "https://www.facebook.com/profile.php?id=100044076064428";
                                            launchUrl(Uri.parse(link),
                                                mode: LaunchMode
                                                    .inAppBrowserView);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ZoomIn(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              child: AvatarGlow(
                                animate: true,
                                glowColor: isDarkMode
                                    ? const Color.fromARGB(255, 4, 0, 255)
                                    : Colors.blueAccent,
                                endRadius: 250,
                                duration: const Duration(seconds: 3),
                                repeatPauseDuration:
                                    const Duration(milliseconds: 200),
                                startDelay: const Duration(milliseconds: 100),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 310,
                                      height: 310,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 11, 51, 85),
                                      ),
                                    ),
                                    Container(
                                      width: 290,
                                      height: 290,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                          width: 4,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/profile-pic.png',
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // About Section
                    Container(
                      key: _aboutSectionKey,
                      child: ZoomIn(
                        globalKey: GlobalKey(),
                        repeat: false,
                        duration: 1.seconds,
                        child: const Center(
                          child: AutoSizeText(
                            'About Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeIn(
                      globalKey: GlobalKey(),
                      repeat: false,
                      duration: 1.seconds,
                      child: Center(
                        child: AutoSizeText(
                          'Get to know me :)',
                          style: TextStyle(
                            color: isDarkMode
                                 ? Colors.white
                                 : Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 40.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ZoomIn(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/profile-pic.png',
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextTyperAnimation(
                                    globalKey: GlobalKey(),
                                    repeat: false,
                                    duration: 2.seconds,
                                    curves: Curves.easeInOut,
                                    fade: true,
                                    text:
                                        "I am Adnan Khan, a Flutter Developer. Quick Learner and a Friend :)",
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextTyperAnimation(
                                    globalKey: GlobalKey(),
                                    repeat: false,
                                    duration: 2.seconds,
                                    curves: Curves.easeInOut,
                                    fade: false,
                                    text:
                                        "I’m a passionate Flutter developer dedicated to crafting seamless, visually appealing, and user-friendly applications. "
                                        "I recently completed my Higher Diploma in Software Engineering from Aptech, which provided me with a solid foundation in software development principles and best practices. "
                                        "My journey in app development is driven by a strong commitment to coding, an eagerness to solve complex problems, and an unwavering desire to learn and evolve.\n\n"
                                        "My goal is to understand your vision and turn it into a polished digital reality. Whether it's building responsive UIs or integrating advanced features, "
                                        "I take pride in delivering high-quality work that meets modern standards. Let’s work together to elevate your project and take your business to new heights in the digital world!",
                                    textStyle: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  FadeInLeft(
                                    globalKey: GlobalKey(),
                                    repeat: false,
                                    duration: 1.seconds,
                                    child: GlowButton(
                                      glowColor: Colors.blue,
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                      blurRadius: 20,
                                      splashColor: const Color.fromARGB(
                                          255, 10, 97, 141),
                                      spreadRadius: 1,
                                      width: 140,
                                      child: const AutoSizeText(
                                        'View Resume',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        const link =
                                            "https://drive.google.com/file/d/1yaVM2KevEJAGc9jzXFxjUclNfmOSmEz3/view?usp=sharing";
                                        launchUrl(Uri.parse(link),
                                            mode: LaunchMode.inAppBrowserView);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Skills Section
                    Container(
                      key: _skillsSectionKey,
                      child: ZoomIn(
                        globalKey: GlobalKey(),
                        repeat: false,
                        duration: 1.seconds,
                        child: const Center(
                          child: AutoSizeText(
                            'My Skills Set',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeIn(
                      globalKey: GlobalKey(),
                      repeat: false,
                      duration: 1.seconds,
                      child: Center(
                        child: AutoSizeText(
                          'Expertise & Proficiency: Flutter Development',
                          style: TextStyle(
                            color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: skills
                                  .sublist(0, (skills.length / 2).ceil())
                                  .map((skill) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        skill['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Stack(
                                        children: [
                                          TweenAnimationBuilder<double>(
                                            tween: Tween(
                                                begin: 0,
                                                end: skill['percentage']),
                                            duration:
                                                const Duration(seconds: 2),
                                            builder: (context, value, _) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: isDarkMode
                                                        ? Colors.blue
                                                            .withOpacity(1)
                                                        : Colors.blue
                                                            .withOpacity(0.6),
                                                    blurRadius: 10,
                                                    spreadRadius: 5,
                                                    offset:
                                                        const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: LinearProgressIndicator(
                                                value: value,
                                                minHeight: 35,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                backgroundColor:
                                                    Colors.grey[400],
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                skill['description'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 40),

                          // Right Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: skills
                                  .sublist((skills.length / 2).ceil())
                                  .map((skill) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        skill['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Stack(
                                        children: [
                                          TweenAnimationBuilder<double>(
                                            tween: Tween(
                                                begin: 0,
                                                end: skill['percentage']),
                                            duration:
                                                const Duration(seconds: 2),
                                            builder: (context, value, _) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: isDarkMode
                                                        ? Colors.blue
                                                            .withOpacity(1)
                                                        : Colors.blue
                                                            .withOpacity(0.6),
                                                    blurRadius: 10,
                                                    spreadRadius: 5,
                                                    offset:
                                                        const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: LinearProgressIndicator(
                                                value: value,
                                                minHeight: 35,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                backgroundColor:
                                                    Colors.grey[400],
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: AutoSizeText(
                                                skill['description'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),

//Projects Section

                    Container(
                      key: _projectsSectionKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ZoomIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: const AutoSizeText(
                              'Projects',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: AutoSizeText(
                              'Here are some apps I have worked on.',
                              style: TextStyle(
                                color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final screenWidth = constraints.maxWidth;

                              return Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 16.0,
                                runSpacing: 16.0,
                                children: [
                                  FadeInUp(
                                    globalKey: GlobalKey(),
                                    repeat: false,
                                    duration: 1.seconds,
                                    child: GestureDetector(
                                      onTap: () async {
                                        const link =
                                            "https://github.com/AdnanKhan4/Holy-Quran-App";
                                        launchUrl(Uri.parse(link),
                                            mode: LaunchMode.inAppBrowserView);
                                      },
                                      child: TweenAnimationBuilder(
                                        tween: Tween<double>(
                                            begin: 1, end: _scale1),
                                        duration:
                                            const Duration(milliseconds: 700),
                                        curve: Curves.bounceOut,
                                        builder: (context, scale, child) {
                                          return Transform.scale(
                                            scale: scale,
                                            child: Card(
                                              elevation: _elevation1,
                                              margin: const EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              shadowColor:
                                                  Colors.black.withOpacity(0.5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  height: screenWidth < 600
                                                      ? 250
                                                      : 350,
                                                  width: screenWidth < 600
                                                      ? screenWidth * 0.8
                                                      : 450,
                                                  decoration: BoxDecoration(
                                                    image:
                                                        const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/QuranApp_Mockup.png'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 4,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  FadeInUp(
                                    globalKey: GlobalKey(),
                                    repeat: false,
                                    duration: 1.seconds,
                                    child: GestureDetector(
                                      onTap: () {
                                        showGeneralDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          barrierLabel: "Contact",
                                          pageBuilder: (context, _, __) =>
                                              AlertDialog(
                                            insetPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 80,
                                                    vertical: 24),
                                            contentPadding: EdgeInsets.zero,
                                            titlePadding: EdgeInsets.zero,
                                            content: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 300,
                                                  height: 160,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    gradient: isDarkMode
                                                        ? const LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  10,
                                                                  20,
                                                                  40),
                                                              Color.fromARGB(
                                                                  255,
                                                                  4,
                                                                  63,
                                                                  134),
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          )
                                                        : const LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  34,
                                                                  113,
                                                                  241),
                                                              Color.fromARGB(
                                                                  255,
                                                                  169,
                                                                  216,
                                                                  255),
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26),
                                                  ),
                                                  child: const Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Coming Soon",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "Stay tuned this app is under development!",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -10,
                                                  right: -10,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.red),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          transitionBuilder:
                                              (context, anim, _, child) {
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
                                      },
                                      child: TweenAnimationBuilder(
                                        tween: Tween<double>(
                                            begin: 1, end: _scale2),
                                        duration:
                                            const Duration(milliseconds: 700),
                                        curve: Curves.bounceOut,
                                        builder: (context, scale, child) {
                                          return Transform.scale(
                                            scale: scale,
                                            child: Card(
                                              elevation: _elevation2,
                                              margin: const EdgeInsets.all(16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              shadowColor:
                                                  Colors.black.withOpacity(0.5),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height: screenWidth < 600
                                                          ? 250
                                                          : 350,
                                                      width: screenWidth < 600
                                                          ? screenWidth * 0.8
                                                          : 450,
                                                      decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/RestaurantApp_Mockup.png'),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          width: 4,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Services Section
                    Container(
                      key: _servicesSectionKey,
                      child: ZoomIn(
                        globalKey: GlobalKey(),
                        repeat: false,
                        duration: 1.seconds,
                        child: const Center(
                          child: AutoSizeText(
                            'Services',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeIn(
                      globalKey: GlobalKey(),
                      repeat: false,
                      duration: 1.seconds,
                      child: Center(
                        child: AutoSizeText(
                          'We provide top-notch solutions tailored for your business needs.',
                          style: TextStyle(
                           color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Card 1
                          Expanded(
                            child: FadeInLeft(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: "Contact",
                                        pageBuilder: (context, _, __) =>
                                            AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 80, vertical: 24),
                                          contentPadding: EdgeInsets.zero,
                                          titlePadding: EdgeInsets.zero,
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: 300,
                                                height: 160,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  gradient: isDarkMode
                                                      ? const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                10, 20, 40),
                                                            Color.fromARGB(255,
                                                                4, 63, 134),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        )
                                                      : const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                34, 113, 241),
                                                            Color.fromARGB(255,
                                                                169, 216, 255),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "Hire Me",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://wa.me/923442425726";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .whatsapp,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "WhatsApp",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://www.upwork.com/freelancers/~01e5a488c532df3fad?mp_source=share";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .upwork,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "Upwork",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        transitionBuilder:
                                            (context, anim, _, child) {
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
                                    },
                                    child: Container(
                                      height: 260,
                                      width: 360,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 40),
                                          AutoSizeText(
                                            "Mobile App Development",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          AutoSizeText(
                                            "Transforming your ideas into seamless mobile and web experiences through innovative app development with Flutter.",
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
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.mobile,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Card 2
                          Expanded(
                            child: FadeInDown(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: "Contact",
                                        pageBuilder: (context, _, __) =>
                                            AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 80, vertical: 24),
                                          contentPadding: EdgeInsets.zero,
                                          titlePadding: EdgeInsets.zero,
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: 300,
                                                height: 160,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  gradient: isDarkMode
                                                      ? const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                10, 20, 40),
                                                            Color.fromARGB(255,
                                                                4, 63, 134),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        )
                                                      : const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                34, 113, 241),
                                                            Color.fromARGB(255,
                                                                169, 216, 255),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "Hire Me",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://wa.me/923442425726";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .whatsapp,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "WhatsApp",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://www.upwork.com/freelancers/~01e5a488c532df3fad?mp_source=share";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .upwork,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "Upwork",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        transitionBuilder:
                                            (context, anim, _, child) {
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
                                    },
                                    child: Container(
                                      height: 260,
                                      width: 360,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 40),
                                          AutoSizeText(
                                            "UI/UX Designing",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          AutoSizeText(
                                            "Creating user-friendly designs that make your apps easy to use and visually appealing, ensuring a delightful experience for your audience.",
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
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.pencil,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Card 3
                          Expanded(
                            child: FadeInRight(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel: "Contact",
                                        pageBuilder: (context, _, __) =>
                                            AlertDialog(
                                          insetPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 80, vertical: 24),
                                          contentPadding: EdgeInsets.zero,
                                          titlePadding: EdgeInsets.zero,
                                          content: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: 300,
                                                height: 160,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  gradient: isDarkMode
                                                      ? const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                10, 20, 40),
                                                            Color.fromARGB(255,
                                                                4, 63, 134),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        )
                                                      : const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                34, 113, 241),
                                                            Color.fromARGB(255,
                                                                169, 216, 255),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      "Hire Me",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://wa.me/923442425726";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .whatsapp,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "WhatsApp",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    SizedBox(
                                                      width: 150,
                                                      child:
                                                          ElevatedButton.icon(
                                                        onPressed: () {
                                                          const link =
                                                              "https://www.upwork.com/freelancers/~01e5a488c532df3fad?mp_source=share";
                                                          launchUrl(
                                                              Uri.parse(link),
                                                              mode: LaunchMode
                                                                  .inAppBrowserView);
                                                        },
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .upwork,
                                                          color: Colors.white,
                                                        ),
                                                        label: const Text(
                                                          "Upwork",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                        Icons.cancel,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        transitionBuilder:
                                            (context, anim, _, child) {
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
                                    },
                                    child: Container(
                                      height: 260,
                                      width: 360,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 40),
                                          Text(
                                            "Firebase Integration",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Implement robust backend solutions using Firebase for authentication, database, cloud storage, and real-time notifications.",
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
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              blurRadius: 20,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          FontAwesomeIcons.cloud,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Contacts Section
                    Container(
                      key: _contactSectionKey,
                      child: ZoomIn(
                        globalKey: GlobalKey(),
                        repeat: false,
                        duration: 1.seconds,
                        child: const Center(
                          child: AutoSizeText(
                            'Get In Touch',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeIn(
                      globalKey: GlobalKey(),
                      repeat: false,
                      duration: 1.seconds,
                      child: Center(
                        child: AutoSizeText(
                          'Looking to Grow Your Business through App Development?',
                          style: TextStyle(
                           color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    FadeIn(
                      globalKey: GlobalKey(),
                      repeat: false,
                      duration: 1.seconds,
                      child: Center(
                        child: AutoSizeText(
                          'Let’s Chat for Tips!',
                          style: TextStyle(
                            color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 40.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: FadeInLeft(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AutoSizeText(
                                      "Call Me",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    AutoSizeText(
                                      "+923442425726",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(height: 20),
                                    AutoSizeText(
                                      "Mail Me:",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    AutoSizeText(
                                      "Adnankhan40340@gmail.com",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextTyperAnimation(
                                            globalKey: GlobalKey(),
                                            repeat: false,
                                            duration: 1.seconds,
                                            curves: Curves.easeInOut,
                                            fade: true,
                                            text:
                                                'Ready to Share Your Thoughts? Let\'s Start!',
                                            textStyle: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 8.0),
                                          TextTyperAnimation(
                                            globalKey: GlobalKey(),
                                            repeat: false,
                                            duration: 1.seconds,
                                            curves: Curves.easeInOut,
                                            fade: false,
                                            text:
                                                'Got an innovative idea for app development, UI/UX design or web app development? Share your thoughts and let’s collaborate to turn your vision into reality.',
                                            textStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: isDarkMode
                                                  ? Colors.white
                                                  : Colors.white70,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Form
                                    Form(
                                      key: _formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: _nameController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Your Name',
                                                      labelStyle: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors.black87
                                                              : Colors.white70),
                                                      hintText:
                                                          'Write your Name here...',
                                                      hintStyle: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors.black54
                                                              : Colors.white54),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide: BorderSide(
                                                            color: isDarkMode
                                                                ? Colors.blue
                                                                : Colors
                                                                    .blueGrey
                                                                    .shade700),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide: BorderSide(
                                                            color: isDarkMode
                                                                ? Colors.blue
                                                                : Colors
                                                                    .blueGrey
                                                                    .shade700),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: isDarkMode
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                    ),
                                                    style: TextStyle(
                                                        color: isDarkMode
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize: 16.0),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 16.0),
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        _emailController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Your Email',
                                                      labelStyle: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors.black87
                                                              : Colors.white70),
                                                      hintText:
                                                          'Write your Email here...',
                                                      hintStyle: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors.black54
                                                              : Colors.white54),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide: BorderSide(
                                                            color: isDarkMode
                                                                ? Colors.blue
                                                                : Colors
                                                                    .blueGrey
                                                                    .shade700),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide: BorderSide(
                                                            color: isDarkMode
                                                                ? Colors.blue
                                                                : Colors
                                                                    .blueGrey
                                                                    .shade700),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2.0),
                                                      ),
                                                      filled: true,
                                                      fillColor: isDarkMode
                                                          ? Colors.white
                                                          : Colors.transparent,
                                                    ),
                                                    style: TextStyle(
                                                        color: isDarkMode
                                                            ? Colors.black
                                                            : Colors.white,
                                                        fontSize: 16.0),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your email';
                                                      } else if (!RegExp(
                                                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                                                          .hasMatch(value)) {
                                                        return 'Please enter a valid email address';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 16.0),
                                            TextFormField(
                                              controller: _messageController,
                                              decoration: InputDecoration(
                                                labelText: 'Your Message',
                                                labelStyle: TextStyle(
                                                    color: isDarkMode
                                                        ? Colors.black87
                                                        : Colors.white70),
                                                hintText:
                                                    'Write your message here...',
                                                hintStyle: TextStyle(
                                                    color: isDarkMode
                                                        ? Colors.black54
                                                        : Colors.white54),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide.none,
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                      color: isDarkMode
                                                          ? Colors.blue
                                                          : Colors.blueGrey
                                                              .shade700),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueAccent,
                                                      width: 2.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: BorderSide(
                                                      color: isDarkMode
                                                          ? Colors.blue
                                                          : Colors.blueGrey
                                                              .shade700),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueAccent,
                                                      width: 2.0),
                                                ),
                                                filled: true,
                                                fillColor: isDarkMode
                                                    ? Colors.white
                                                    : Colors.transparent,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0,
                                                        horizontal: 24.0),
                                              ),
                                              maxLines: 5,
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 16.0),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your message';
                                                }
                                                return null;
                                              },
                                            ),

                                            const SizedBox(height: 20.0),
                                            // Submit Button
                                            Center(
                                                child: GlowButton(
                                              glowColor: Colors.blue,
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              blurRadius: 20,
                                              splashColor: const Color.fromARGB(
                                                  255, 10, 97, 141),
                                              spreadRadius: 1,
                                              width: 140,
                                              child: const AutoSizeText(
                                                'Submit',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  final name =
                                                      _nameController.text;
                                                  final email =
                                                      _emailController.text;
                                                  final message =
                                                      _messageController.text;

                                                  await sendEmail(context, name,
                                                      email, message);

                                                  _nameController.clear();
                                                  _emailController.clear();
                                                  _messageController.clear();
                                                }
                                              },
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 60.0),
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FadeInLeft(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ZoomIn(
                                        globalKey: GlobalKey(),
                                        repeat: false,
                                        duration: 1.seconds,
                                        child: const AutoSizeText(
                                          'GET IN TOUCH',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      const AutoSizeText(
                                        'Email Address',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const AutoSizeText(
                                        'Adnankhan40340@gmail.com',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(height: 15),
                                      const AutoSizeText(
                                        'Phone Number',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const AutoSizeText(
                                        '+923442425726',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(height: 15),
                                      const AutoSizeText(
                                        'Location',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const AutoSizeText(
                                        'Karachi, Sindh, Pakistan',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ZoomIn(
                                      globalKey: GlobalKey(),
                                      repeat: false,
                                      duration: 1.seconds,
                                      child: const AutoSizeText(
                                        'ABOUT ME',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextTyperAnimation(
                                      globalKey: GlobalKey(),
                                      repeat: false,
                                      duration: 1.seconds,
                                      curves: Curves.easeInOut,
                                      fade: false,
                                      text:
                                          "I’m a passionate Flutter developer dedicated to crafting seamless, visually appealing, and user-friendly applications. "
                                          "I recently completed my Higher Diploma in Software Engineering from Aptech, which provided me with a solid foundation in software development principles and best practices. "
                                          "My journey in app development is driven by a strong commitment to coding, an eagerness to solve complex problems, and an unwavering desire to learn and evolve.",
                                      textStyle: const TextStyle(
                                          color: Colors.white70, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white24, thickness: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FadeInLeft(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AutoSizeText(
                                        'Developed in ',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12),
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.blue,
                                        size: 14,
                                      ),
                                      AutoSizeText(
                                        ' with Flutter by Adnan Khan.',
                                        style: TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                FadeInRight(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            FontAwesomeIcons.instagram),
                                        color: Colors.white,
                                        iconSize: 24,
                                        onPressed: () {
                                          const link =
                                              "https://www.instagram.com/__adnankhan._";
                                          launchUrl(Uri.parse(link),
                                              mode:
                                                  LaunchMode.inAppBrowserView);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            FontAwesomeIcons.linkedin),
                                        color: Colors.white,
                                        iconSize: 24,
                                        onPressed: () {
                                          const link =
                                              "https://www.linkedin.com/in/adnan-khan-5611981ba/";
                                          launchUrl(Uri.parse(link),
                                              mode:
                                                  LaunchMode.inAppBrowserView);
                                        },
                                      ),
                                      IconButton(
                                        icon:
                                            const Icon(FontAwesomeIcons.github),
                                        color: Colors.white,
                                        iconSize: 24,
                                        onPressed: () {
                                          const link =
                                              "https://github.com/AdnanKhan4";
                                          launchUrl(Uri.parse(link),
                                              mode:
                                                  LaunchMode.inAppBrowserView);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.facebook),
                                        color: Colors.white,
                                        iconSize: 24,
                                        onPressed: () {
                                          const link =
                                              "https://www.facebook.com/profile.php?id=100044076064428";
                                          launchUrl(Uri.parse(link),
                                              mode:
                                                  LaunchMode.inAppBrowserView);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // FloatingActionButton
      floatingActionButton: FadeInDown(
        globalKey: GlobalKey(),
        repeat: false,
        duration: 1.seconds,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
