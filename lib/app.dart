import 'package:flutter/material.dart';

import 'screens/activity_screen.dart';
import 'screens/home_feed_screen.dart';
import 'screens/home_page_screen.dart';
import 'screens/user_activity_screen.dart';
import 'theme/bidwin_theme.dart';
import 'widgets/bidwin_splash_screen.dart';

class BidWinApp extends StatelessWidget {
  const BidWinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BidWin',
      debugShowCheckedModeBanner: false,
      theme: BidWinTheme.themeData,
      home: const BidWinHomeShell(),
      // Prevent text scaling on web/mobile for consistent UI
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}

class BidWinHomeShell extends StatefulWidget {
  const BidWinHomeShell({super.key});

  @override
  State<BidWinHomeShell> createState() => _BidWinHomeShellState();
}

class _BidWinHomeShellState extends State<BidWinHomeShell> {
  late final PageController _pageController;
  int _currentIndex = 1; // Start on HomeFeedScreen (middle page)
  bool _splashVisible = true;
  bool _hideSplash = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1); // Start on feed screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1400), () {
        if (mounted) {
          setState(() {
            _splashVisible = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: [
                HomePageScreen(
                  onNavigateToAccount: () {
                    _pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onNavigateToFeed: () {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onNavigateToActivity: () {
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ), // Swipe right from feed
                const HomeFeedScreen(), // Default feed screen
                const ActivityScreen(), // Activity screen
                const UserActivityScreen(), // Swipe left from feed (Account)
              ],
            ),
            // Only show page indicators on feed and activity screens (not on home page)
            if (_currentIndex != 0)
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: _currentIndex == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? BidWinTheme.red
                            : Colors.white54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            if (!_hideSplash)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: !_splashVisible,
                  child: AnimatedOpacity(
                    opacity: _splashVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    onEnd: () {
                      if (!_splashVisible) {
                        setState(() => _hideSplash = true);
                      }
                    },
                    child: const BidWinSplashScreen(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

