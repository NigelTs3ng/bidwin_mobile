import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class UserActivityScreen extends StatefulWidget {
  const UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  int _bidCoins = 1250; // TODO: fetch bidCoins from Supabase
  bool _hasLinkedCard = false; // TODO: check if card is linked from Supabase
  double _referralBalance = 0.00; // TODO: fetch from Supabase

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: BidWinTheme.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile section at top
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: BidWinTheme.cardBackground,
                      child: const Text(
                        'n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'nigelt71178',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // BidCoin wallet section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
              // View Profile button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // TODO: Navigate to profile page
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'View Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Account heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Account',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Two cards side by side
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _AccountCard(
                        icon: Icons.people,
                        title: 'Referrals & Credits',
                        subtitle: 'Balance: US\$${_referralBalance.toStringAsFixed(2)}',
                        onTap: () {
                          // TODO: Navigate to referrals page
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _AccountCard(
                        icon: Icons.workspace_premium,
                        title: 'My Rewards',
                        subtitle: 'View Coupons',
                        onTap: () {
                          // TODO: Navigate to rewards page
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Account settings list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _AccountListItem(
                      icon: Icons.people,
                      title: 'Affiliate Program: Earn Cash',
                      onTap: () {
                        // TODO: Navigate to affiliate program
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.payment,
                      title: 'Payments & Shipping',
                      onTap: () {
                        // TODO: Navigate to payments & shipping
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.location_on,
                      title: 'Addresses',
                      onTap: () {
                        // TODO: Navigate to addresses
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.verified,
                      title: 'Verified Buyer',
                      onTap: () {
                        // TODO: Navigate to verification
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        // TODO: Navigate to notifications
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.email,
                      title: 'Change Email',
                      onTap: () {
                        // TODO: Navigate to change email
                      },
                    ),
                    _AccountListItem(
                      icon: Icons.lock,
                      title: 'Change Password',
                      onTap: () {
                        // TODO: Navigate to change password
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BidWinTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountListItem extends StatelessWidget {
  const _AccountListItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white70,
              size: 20,
            ),
          ],
        ),
      ),
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
                child: Image.asset(
                  'lib/assets/images/BidCoin-logo.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to icon if image fails to load
                    return const Icon(
                      Icons.account_balance_wallet,
                      color: BidWinTheme.blue,
                      size: 24,
                    );
                  },
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
