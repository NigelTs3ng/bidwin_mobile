import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class UserActivityScreen extends StatefulWidget {
  const UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  int _selectedTab = 0;
  int _bidCoins = 1250; // TODO: fetch bidCoins from Supabase
  bool _hasLinkedCard = false; // TODO: check if card is linked from Supabase

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _PaymentCardSection(
            bidCoins: _bidCoins,
            hasLinkedCard: _hasLinkedCard,
            onLinkCard: () {
              // TODO: integrate Stripe for credit card linking
              showDialog(
                context: context,
                builder: (context) => _LinkCardDialog(
                  onLink: () {
                    setState(() {
                      _hasLinkedCard = true;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              );
            },
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

class _PaymentCardSection extends StatelessWidget {
  const _PaymentCardSection({
    required this.bidCoins,
    required this.hasLinkedCard,
    required this.onLinkCard,
  });

  final int bidCoins;
  final bool hasLinkedCard;
  final VoidCallback onLinkCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BidWinTheme.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: BidWinTheme.blue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: BidWinTheme.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: BidWinTheme.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BidCoins',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white70,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatBidCoins(bidCoins),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: BidWinTheme.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: Colors.white.withOpacity(0.1),
            height: 1,
          ),
          const SizedBox(height: 16),
          if (hasLinkedCard)
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Credit card linked',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onLinkCard,
                icon: const Icon(Icons.add_card, size: 20),
                label: const Text('Link Credit Card'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: BidWinTheme.red, width: 1.5),
                  foregroundColor: BidWinTheme.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatBidCoins(int coins) {
    if (coins >= 1000) {
      return '${(coins / 1000).toStringAsFixed(1)}K';
    }
    return coins.toString();
  }
}

class _LinkCardDialog extends StatefulWidget {
  const _LinkCardDialog({required this.onLink});

  final VoidCallback onLink;

  @override
  State<_LinkCardDialog> createState() => _LinkCardDialogState();
}

class _LinkCardDialogState extends State<_LinkCardDialog> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      backgroundColor: BidWinTheme.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Link Credit Card',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    decoration: InputDecoration(
                      labelText: 'Expiry',
                      hintText: 'MM/YY',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '123',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                hintText: 'John Doe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO: integrate Stripe for credit card linking
                  if (_cardNumberController.text.isNotEmpty &&
                      _expiryController.text.isNotEmpty &&
                      _cvvController.text.isNotEmpty &&
                      _nameController.text.isNotEmpty) {
                    widget.onLink();
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: BidWinTheme.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Link Card',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
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

