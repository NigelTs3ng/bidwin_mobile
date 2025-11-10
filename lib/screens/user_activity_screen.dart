import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class UserActivityScreen extends StatefulWidget {
  const UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  int _selectedTab = 0;

  final List<Map<String, String>> _myBids = [
    {
      'title': 'Vintage Comic Collection',
      'status': 'Leading',
      'amount': '\$180.00',
      'date': 'Nov 10, 2025',
    },
    {
      'title': 'Rare Trading Card Pack',
      'status': 'Outbid',
      'amount': '\$92.50',
      'date': 'Nov 9, 2025',
    },
  ];

  final List<Map<String, String>> _myPurchases = [
    {
      'title': 'Limited Art Print #204',
      'status': 'Shipped',
      'amount': '\$340.00',
      'date': 'Nov 4, 2025',
    },
    {
      'title': 'Collector\'s Vinyl Set',
      'status': 'Delivered',
      'amount': '\$129.00',
      'date': 'Oct 31, 2025',
    },
  ];

  final List<Map<String, String>> _myRaffles = [
    {
      'title': 'Luxury Getaway Weekend',
      'status': 'Pending Draw',
      'amount': '3 tickets',
      'date': 'Nov 12, 2025',
    },
    {
      'title': 'Gaming Rig Bundle',
      'status': 'Won',
      'amount': '1 ticket',
      'date': 'Nov 1, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tabContent = <int, List<Map<String, String>>>{
      0: _myBids,
      1: _myPurchases,
      2: _myRaffles,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My BidWin',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: BidWinTheme.blue,
                    child: const Text(
                      'BW',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@bidwin_user',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Level 3 Seller • 128 followers',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: BidWinTheme.cardBackground,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                for (var index = 0; index < 3; index++)
                  Expanded(
                    child: _ActivityTabButton(
                      label: switch (index) {
                        0 => 'My Bids',
                        1 => 'My Purchases',
                        _ => 'My Raffles',
                      },
                      selected: _selectedTab == index,
                      onTap: () => setState(() => _selectedTab = index),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: _ActivityListView(
              key: ValueKey(_selectedTab),
              entries: tabContent[_selectedTab] ?? const <Map<String, String>>[],
            ),
          ),
        ),
        // TODO: fetch user activity (bids/purchases/raffles) from Supabase
      ],
    );
  }
}

class _ActivityTabButton extends StatelessWidget {
  const _ActivityTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: selected ? BidWinTheme.blue : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.white70,
                ),
          ),
        ),
      ),
    );
  }
}

class _ActivityListView extends StatelessWidget {
  const _ActivityListView({
    super.key,
    required this.entries,
  });

  final List<Map<String, String>> entries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (entries.isEmpty) {
      return Center(
        child: Text(
          'No activity yet.',
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: BidWinTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry['title'] ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(
                      entry['status'] ?? '',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: Colors.white10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry['amount'] ?? '',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    entry['date'] ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

