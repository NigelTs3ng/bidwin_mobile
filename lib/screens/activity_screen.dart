import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Purchases', 'Bids', 'Raffles', 'Saved'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: BidWinTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  Text(
                    'Activity',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Tab navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(
                  _tabs.length,
                  (index) => Expanded(
                    child: _ActivityTab(
                      label: _tabs[index],
                      selected: _selectedTab == index,
                      onTap: () {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Promotional referral card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ReferralCard(),
            ),
            const SizedBox(height: 20),
            // Main content area
            Expanded(
              child: _ActivityContent(selectedTab: _selectedTab),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityTab extends StatelessWidget {
  const _ActivityTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _ReferralCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BidWinTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Earn up to US\$200 towards your next purchase!',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // TODO: Handle refer friends
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Refer Friends',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // BidCoin logo
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'lib/assets/images/BidCoin-logo.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to coins graphic if image fails to load
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.purple.withOpacity(0.3),
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: _CoinStack(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          // Bottom coin
          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          // Middle coin
          Positioned(
            bottom: 15,
            left: 15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          // Top coin with gift icon
          Positioned(
            bottom: 30,
            left: 10,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Radiating lines
                  ...List.generate(8, (index) {
                    final angle = (index * 45) * math.pi / 180;
                    final radius = 15.0;
                    final cos = math.cos(angle);
                    final sin = math.sin(angle);
                    return Positioned(
                      left: 20 + radius * cos - 1,
                      top: 20 + radius * sin - 4,
                      child: Transform.rotate(
                        angle: angle,
                        child: Container(
                          width: 2,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                      ),
                    );
                  }),
                  // Gift box icon
                  Center(
                    child: Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityContent extends StatelessWidget {
  const _ActivityContent({required this.selectedTab});

  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Empty state for all tabs
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getEmptyStateTitle(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _getEmptyStateSubtitle(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getEmptyStateTitle() {
    switch (selectedTab) {
      case 0:
        return 'Your purchases will live here';
      case 1:
        return 'Your bids will live here';
      case 2:
        return 'Your raffles will live here';
      case 3:
        return 'Your saved items will live here';
      default:
        return 'Your activity will live here';
    }
  }

  String _getEmptyStateSubtitle() {
    switch (selectedTab) {
      case 0:
        return 'Go win an auction or two, then check back here for your purchase history.';
      case 1:
        return 'Start placing bids on items you love, then check back here to track your bids.';
      case 2:
        return 'Enter raffles and check back here to see your raffle history.';
      case 3:
        return 'Save items you\'re interested in, then check back here to see your saved items.';
      default:
        return 'Your activity will appear here.';
    }
  }
}

