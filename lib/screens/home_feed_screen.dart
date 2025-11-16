import 'package:flutter/material.dart';

import '../widgets/bidwin_post.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final PageController _pageController = PageController();
  double _scrollProgress = 0.0;

  static final List<Map<String, dynamic>> _mockFeed = [
    {
      'type': 'live_auction',
      'title': 'Limited Edition Sneaker Drop',
      'sellerName': 'SneakerVault',
      'currentPrice': 220.0,
      'timeRemaining': '03:24 left',
    },
    {
      'type': 'raffle',
      'title': 'PS5 Holiday Mega Raffle',
      'sellerName': 'GamerCentral',
      'ticketPrice': 9.99,
      'timeRemaining': 'Drawing in 5h',
    },
    {
      'type': 'market_item',
      'title': 'Vintage Rolex Oyster Perpetual',
      'sellerName': 'Timekeepers Co.',
      'currentPrice': 14500.0,
      'timeRemaining': 'Buy instantly',
    },
    {
      'type': 'live_auction',
      'title': 'Signed NBA Memorabilia Set',
      'sellerName': 'CourtLegends',
      'currentPrice': 890.0,
      'timeRemaining': 'LIVE now',
    },
    {
      'type': 'raffle',
      'title': 'Tesla Model 3 Giveaway',
      'sellerName': 'DriveLuck',
      'ticketPrice': 49.0,
      'timeRemaining': 'Closes tonight',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_updateScrollProgress);
  }

  @override
  void dispose() {
    _pageController.removeListener(_updateScrollProgress);
    _pageController.dispose();
    super.dispose();
  }

  void _updateScrollProgress() {
    if (_pageController.hasClients) {
      final currentPage = _pageController.page ?? 0.0;
      setState(() {
        // Calculate fade based on scroll progress (fade out over first 0.5 pages)
        _scrollProgress = (currentPage * 2).clamp(0.0, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: _mockFeed.length,
          itemBuilder: (context, index) {
            final item = _mockFeed[index];
            return BidWinPost(
              type: item['type'] as String,
              title: item['title'] as String,
              sellerName: item['sellerName'] as String,
              timeRemaining: item['timeRemaining'] as String,
              currentPrice: item['currentPrice'] as double?,
              ticketPrice: item['ticketPrice'] as double?,
            );
          },
        ),
        Positioned(
          bottom: 18,
          left: 20,
          child: Opacity(
            opacity: 1.0 - _scrollProgress,
            child: const Text(
              'Swipe up for more',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        // TODO: fetch feed items from Supabase
      ],
    );
  }
}

