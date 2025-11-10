import 'package:flutter/material.dart';

import '../widgets/bidwin_post.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
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
          top: 12,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'BidWin',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 18,
          left: 20,
          child: Text(
            'Swipe up for more',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.1,
            ),
          ),
        ),
        // TODO: fetch feed items from Supabase
      ],
    );
  }
}

