import 'package:flutter/material.dart';
import '../auth/auth_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingBase()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7B2CBF), Color(0xFF9D4EDD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Text(
                  'e',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B2CBF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingBase extends StatefulWidget {
  const OnboardingBase({super.key});

  @override
  State<OnboardingBase> createState() => _OnboardingBaseState();
}

class _OnboardingBaseState extends State<OnboardingBase> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Discover Amazing Event In Your City',
      'subtitle': 'The best event we have prepared for you',
    },
    {
      'title': 'Experience The Ultimate Local Event Right',
      'subtitle': 'The best event we have prepared for you',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignInScreen()),
                  ),
                  child: const Text(
                    'Skip >',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 64,
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        onboardingData[index]['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        onboardingData[index]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 4,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF9D4EDD)
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9D4EDD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_currentPage == onboardingData.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      );
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
