import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class BidWinPost extends StatelessWidget {
  const BidWinPost({
    super.key,
    required this.type,
    required this.title,
    required this.sellerName,
    required this.timeRemaining,
    this.currentPrice,
    this.ticketPrice,
  });

  final String type;
  final String title;
  final String sellerName;
  final String timeRemaining;
  final double? currentPrice;
  final double? ticketPrice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLive = type == 'live_auction';
    final isRaffle = type == 'raffle';
    final isMarket = type == 'market' || type == 'market_item';

    late final String typeLabel;
    late final Color pillColor;
    late final String primaryActionLabel;
    late final Color accentColor;
    late final Widget priceWidget;

    if (isLive) {
      typeLabel = 'LIVE';
      pillColor = BidWinTheme.red;
      accentColor = BidWinTheme.red;
      primaryActionLabel = 'Bid Now';
      priceWidget = _PriceText(
        label: 'Current Bid',
        value: currentPrice != null ? '\$${currentPrice!.toStringAsFixed(2)}' : '--',
      );
    } else if (isRaffle) {
      typeLabel = 'RAFFLE';
      pillColor = BidWinTheme.blue;
      accentColor = BidWinTheme.blue;
      primaryActionLabel = 'Buy Ticket';
      priceWidget = _PriceText(
        label: 'Ticket Price',
        value: ticketPrice != null ? '\$${ticketPrice!.toStringAsFixed(2)}' : '--',
      );
    } else if (isMarket) {
      typeLabel = 'MARKET';
      pillColor = Colors.white;
      accentColor = Colors.white;
      primaryActionLabel = 'Buy Now';
      priceWidget = _PriceText(
        label: 'Price',
        value: currentPrice != null ? '\$${currentPrice!.toStringAsFixed(2)}' : '--',
      );
    } else {
      typeLabel = type.toUpperCase();
      pillColor = Colors.white;
      accentColor = Colors.white;
      primaryActionLabel = 'Explore';
      priceWidget = _PriceText(label: 'Details', value: '--');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                BidWinTheme.cardBackground.withOpacity(0.88),
                BidWinTheme.cardBackground.withOpacity(0.95),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -40,
                left: -60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withOpacity(0.25),
                  ),
                  child: const SizedBox(width: 160, height: 160),
                ),
              ),
              Positioned(
                bottom: -80,
                right: -60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withOpacity(0.18),
                  ),
                  child: const SizedBox(width: 200, height: 200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: pillColor,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  typeLabel,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: isMarket ? BidWinTheme.red : Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                timeRemaining,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Seller: $sellerName',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          priceWidget,
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 160,
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: accentColor,
                                foregroundColor: isMarket ? BidWinTheme.red : Colors.white,
                                textStyle: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                // TODO: integrate Stripe for payments / ticket buys
                              },
                              child: Text(primaryActionLabel),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    _ActionBar(accentColor: accentColor),
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

class _PriceText extends StatelessWidget {
  const _PriceText({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: Colors.white70,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final iconSize = 28.0;
    final iconStyle = IconButton.styleFrom(
      foregroundColor: Colors.white,
      iconSize: iconSize,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24, width: 2),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: accentColor.withOpacity(0.4),
            child: const Text(
              'BW',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 18),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_outline),
          style: iconStyle,
        ),
        const SizedBox(height: 4),
        Text(
          '1.2K',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 18),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.mode_comment_outlined),
          style: iconStyle,
        ),
        const SizedBox(height: 4),
        Text(
          '256',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 18),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share_outlined),
          style: iconStyle,
        ),
      ],
    );
  }
}

