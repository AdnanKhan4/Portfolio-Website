import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate_on_scroll/flutter_animate_on_scroll.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:portfolio_web/components/service_cards.dart';
import 'package:portfolio_web/env_config.dart';
import 'package:portfolio_web/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileHomepage extends StatefulWidget {
  const MobileHomepage({super.key});

  @override
  State<MobileHomepage> createState() => _MobileHomepageState();
}

class _MobileHomepageState extends State<MobileHomepage>
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
  Future<void> sendEmail(String name, String email, String message) async {


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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

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
    final advancedrawerController = AdvancedDrawerController();

    void drawerControl() {
      advancedrawerController.showDrawer();
    }

    return AdvancedDrawer(
      childDecoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      rtlOpening: false,
      animationDuration: const Duration(milliseconds: 600),
      animationCurve: Curves.easeIn,
      controller: advancedrawerController,
      backdrop: Container(
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
        ),
      ),
      drawer: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/profile-pic.png',
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    const AutoSizeText(
                      "<Adnan Khan/>",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToHomeSection,
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'About',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToAboutSection,
            ),
            ListTile(
              leading: const Icon(
                Icons.lightbulb,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'Skills',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToSkillsSection,
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'Projects',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToProjectsSection,
            ),
            ListTile(
              leading: const Icon(
                Icons.design_services,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'Services',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToServicesSection,
            ),
            ListTile(
              leading: const Icon(
                Icons.contact_phone_rounded,
                color: Colors.white,
              ),
              title: const AutoSizeText(
                'Contact',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: scrollToContactSection,
            ),
            ListTile(
              leading: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.white,
              ),
              title: const Text(
                'Dark Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Switch(
                value: isDarkMode,
                onChanged: toggleDarkMode,
                activeColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ],
        ),
      ),
      child: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: advancedrawerController,
        builder: (context, value, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: isDarkMode
                  ? const Color.fromARGB(255, 34, 113, 241)
                  : const Color.fromARGB(255, 10, 20, 40),
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.menu,
                    color: isDarkMode ? Colors.white : Colors.blue),
                onPressed: drawerControl,
              ),
            ),
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
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      key: _homeSectionKey,
                      height: 650,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SlideTransition(
                                    position: _offsetAnimation,
                                    child: const AutoSizeText(
                                      'WELCOME TO MY PORTFOLIO! 👋',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
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
                                              fontSize: 50,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Khan',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
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
                                                fontSize: 18,
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
                                                fontSize: 18,
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
                                                fontSize: 18,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                mode: LaunchMode.inAppWebView);
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
                                                mode: LaunchMode
                                                    .inAppBrowserView);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              FontAwesomeIcons.github),
                                          color: Colors.white,
                                          iconSize: 24,
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
                                          iconSize: 24,
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
                                endRadius: 150,
                                duration: const Duration(seconds: 3),
                                repeatPauseDuration:
                                    const Duration(milliseconds: 200),
                                startDelay: const Duration(milliseconds: 100),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 180,
                                      height: 180,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 11, 51, 85),
                                      ),
                                    ),
                                    Container(
                                      width: 160,
                                      height: 160,
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
                                        width: 140,
                                        height: 140,
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

                    Container(
                      key: _aboutSectionKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ZoomIn(
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 30),
                          Column(
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
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              FadeInLeft(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: const AutoSizeText(
                                    "I’m a passionate Flutter developer dedicated to crafting seamless, visually appealing, and user-friendly applications. "
                                    "I recently completed my Higher Diploma in Software Engineering from Aptech, which provided me with a solid foundation in software development principles and best practices. "
                                    "My journey in app development is driven by a strong commitment to coding, an eagerness to solve complex problems, and an unwavering desire to learn and evolve.\n\n"
                                    "My goal is to understand your vision and turn it into a polished digital reality. Whether it's building responsive UIs or integrating advanced features, "
                                    "I take pride in delivering high-quality work that meets modern standards. Let’s work together to elevate your project and take your business to new heights in the digital world!",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  )),
                              const SizedBox(height: 40),
                              FadeInDown(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: GlowButton(
                                  glowColor: Colors.blue,
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                  blurRadius: 20,
                                  splashColor:
                                      const Color.fromARGB(255, 10, 97, 141),
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
                        ],
                      ),
                    ),

                    Container(
                      key: _skillsSectionKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ZoomIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: const Center(
                              child: AutoSizeText(
                                'My Skills Set',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FadeIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: Center(
                              child: AutoSizeText(
                                'Expertise & Proficiency\n Flutter Development',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Skills List
                          Column(
                            children: skills.map((skill) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          duration: const Duration(seconds: 2),
                                          builder: (context, value, _) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue
                                                      .withOpacity(0.6),
                                                  blurRadius: 10,
                                                  spreadRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: LinearProgressIndicator(
                                              value: value,
                                              minHeight: 25,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              backgroundColor: Colors.grey[400],
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
                        ],
                      ),
                    ),

                    //Projects Section

                    Container(
                      key: _projectsSectionKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        children: [
                          ZoomIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: const AutoSizeText(
                              'Projects',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          FadeIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: AutoSizeText(
                              'Here are some apps I have worked on.',
                              style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // First Card

                              FadeInLeft(
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
                                  child: Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 250,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/QuranApp_Mockup.png'),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Second Card
                              FadeInRight(
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
                                                horizontal: 80, vertical: 24),
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
                                                          Color.fromARGB(
                                                              255, 10, 20, 40),
                                                          Color.fromARGB(
                                                              255, 4, 63, 134),
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
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
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(26),
                                              ),
                                              child: const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Coming Soon",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    "Stay tuned this app is under development!",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white),
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
                                                  icon: const Icon(Icons.cancel,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
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
                                  child: Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    shadowColor: Colors.black.withOpacity(0.5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 250,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/RestaurantApp_Mockup.png'),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Container(
                      key: _servicesSectionKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 40.0),
                      child: Column(
                        children: [
                          ZoomIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: const Center(
                              child: AutoSizeText(
                                'Services',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
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
                                textAlign: TextAlign.center,
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

                          const SizedBox(height: 40),

                          // Service Cards

                          FadeInUp(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: ServiceCard(
                              title: 'Mobile App Development',
                              description:
                                  'Transforming your ideas into seamless mobile and web experiences through innovative app development with Flutter.',
                              icon: 'mobile',
                              heroTag: 'mobile_app',
                              isDarkMode: isDarkMode,
                            ),
                          ),
                          FadeInRight(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: ServiceCard(
                              title: 'UI/UX Designing',
                              description:
                                  'Creating user-friendly designs that make your apps easy to use and visually appealing, ensuring a delightful experience for your audience.',
                              icon: 'pencil',
                              heroTag: 'ui_ux',
                              isDarkMode: isDarkMode,
                            ),
                          ),
                          FadeInDown(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: ServiceCard(
                              title: 'Firebase Integration',
                              description:
                                  'Implement robust backend solutions using Firebase for authentication, database, cloud storage, and real-time notifications.',
                              icon: 'cloud',
                              heroTag: 'firebase',
                              isDarkMode: isDarkMode,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Contacts Section
                    Container(
                      key: _contactSectionKey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0),
                      child: Column(
                        children: [
                          ZoomIn(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            child: const Center(
                              child: AutoSizeText(
                                'Get In Touch',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
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
                                textAlign: TextAlign.center,
                                'Looking to Grow Your Business through App Development?',
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextTyperAnimation(
                              globalKey: GlobalKey(),
                              repeat: false,
                              duration: 1.seconds,
                              curves: Curves.easeInOut,
                              fade: true,
                              text:
                                  'Ready to Share Your Thoughts? Let\'s Start!',
                              textStyle: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          TextTyperAnimation(
                            globalKey: GlobalKey(),
                            repeat: false,
                            duration: 1.seconds,
                            curves: Curves.easeInOut,
                            fade: false,
                            text:
                                'Got an innovative idea for app development, UI/UX design or web app development? Share your thoughts and let’s collaborate to turn your vision into reality.',
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              color: isDarkMode ? Colors.white : Colors.white70,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Form Section
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Your Name',
                                        labelStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.black87
                                                : Colors.white70),
                                        hintText: 'Write your Name here...',
                                        hintStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.black54
                                                : Colors.white54),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: isDarkMode
                                                  ? Colors.blue
                                                  : Colors.blueGrey.shade700),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: isDarkMode
                                                  ? Colors.blue
                                                  : Colors.blueGrey.shade700),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2.0),
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Your Email',
                                        labelStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.black87
                                                : Colors.white70),
                                        hintText: 'Write your Email here...',
                                        hintStyle: TextStyle(
                                            color: isDarkMode
                                                ? Colors.black54
                                                : Colors.white54),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: isDarkMode
                                                  ? Colors.blue
                                                  : Colors.blueGrey.shade700),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: isDarkMode
                                                  ? Colors.blue
                                                  : Colors.blueGrey.shade700),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2.0),
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
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email';
                                        } else if (!RegExp(
                                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                                            .hasMatch(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
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
                                    hintText: 'Write your message here...',
                                    hintStyle: TextStyle(
                                        color: isDarkMode
                                            ? Colors.black54
                                            : Colors.white54),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: isDarkMode
                                              ? Colors.blue
                                              : Colors.blueGrey.shade700),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: isDarkMode
                                              ? Colors.blue
                                              : Colors.blueGrey.shade700),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent, width: 2.0),
                                    ),
                                    filled: true,
                                    fillColor: isDarkMode
                                        ? Colors.white
                                        : Colors.transparent,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 24.0),
                                  ),
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16.0),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your message';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30.0),
                                ZoomIn(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: Center(
                                      child: GlowButton(
                                    glowColor: Colors.blue,
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(50),
                                    blurRadius: 20,
                                    splashColor:
                                        const Color.fromARGB(255, 10, 97, 141),
                                    spreadRadius: 1,
                                    width: 140,
                                    child: const AutoSizeText(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        final name = _nameController.text;
                                        final email = _emailController.text;
                                        final message = _messageController.text;

                                        await sendEmail(name, email, message);

                                        _nameController.clear();
                                        _emailController.clear();
                                        _messageController.clear();
                                      }
                                    },
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeIn(
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInLeft(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  'Email Address',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              FadeInRight(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  'Adnankhan40340@gmail.com',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 15),
                              FadeInLeft(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  'Phone Number',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              FadeInRight(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  '+923442425726',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 15),
                              FadeInLeft(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  'Location',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              FadeInRight(
                                globalKey: GlobalKey(),
                                repeat: false,
                                duration: 1.seconds,
                                child: const AutoSizeText(
                                  'Karachi, Sindh, Pakistan',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          FadeIn(
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
                          const SizedBox(height: 40),
                          const Divider(color: Colors.white24, thickness: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeInLeft(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                const SizedBox(height: 10),
                                FadeInDown(
                                  globalKey: GlobalKey(),
                                  repeat: false,
                                  duration: 1.seconds,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Colors.blue,
                child: const Icon(Icons.arrow_upward, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
