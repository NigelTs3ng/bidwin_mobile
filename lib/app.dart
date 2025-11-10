import 'package:flutter/material.dart';

import 'screens/home_feed_screen.dart';
import 'screens/user_activity_screen.dart';
import 'theme/bidwin_theme.dart';

class BidWinApp extends StatelessWidget {
  const BidWinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BidWin',
      debugShowCheckedModeBanner: false,
      theme: BidWinTheme.themeData,
      home: const BidWinHomeShell(),
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
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
              children: const [
                HomeFeedScreen(),
                UserActivityScreen(),
              ],
            ),
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
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
          ],
        ),
      ),
    );
  }
}

