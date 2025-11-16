import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class BidWinPost extends StatefulWidget {
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
  State<BidWinPost> createState() => _BidWinPostState();
}

class _BidWinPostState extends State<BidWinPost> {
  @override
  void initState() {
    super.initState();
  }

  void _showBidDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _BidDialog(
        currentPrice: widget.currentPrice ?? 0.0,
        onBidSubmitted: () {
          Navigator.of(context).pop();
          _showBidSuccessDialog(context);
        },
      ),
    );
  }

  void _showBidSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BidWinTheme.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Bid submitted successfully',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isLive = widget.type == 'live_auction';
    final isRaffle = widget.type == 'raffle';
    final isMarket = widget.type == 'market' || widget.type == 'market_item';

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
        value: widget.currentPrice != null ? '\$${widget.currentPrice!.toStringAsFixed(2)}' : '--',
      );
    } else if (isRaffle) {
      typeLabel = 'RAFFLE';
      pillColor = BidWinTheme.blue;
      accentColor = BidWinTheme.blue;
      primaryActionLabel = 'Buy Ticket';
      priceWidget = _PriceText(
        label: 'Ticket Price',
        value: widget.ticketPrice != null ? '\$${widget.ticketPrice!.toStringAsFixed(2)}' : '--',
      );
    } else if (isMarket) {
      typeLabel = 'MARKET';
      pillColor = Colors.white;
      accentColor = Colors.white;
      primaryActionLabel = 'Buy Now';
      priceWidget = _PriceText(
        label: 'Price',
        value: widget.currentPrice != null ? '\$${widget.currentPrice!.toStringAsFixed(2)}' : '--',
      );
    } else {
      typeLabel = widget.type.toUpperCase();
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
                                widget.timeRemaining,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            widget.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Seller: ${widget.sellerName}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          priceWidget,
                          if (isLive && widget.currentPrice != null) ...[
                            const SizedBox(height: 32),
                            _BidButtons(
                              currentPrice: widget.currentPrice!,
                              onBidPressed: () => _showBidDialog(context),
                            ),
                          ],
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

class _BidButtons extends StatelessWidget {
  const _BidButtons({
    required this.currentPrice,
    required this.onBidPressed,
  });

  final double currentPrice;
  final VoidCallback onBidPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          // Bid Now Button (left, red)
          Expanded(
            flex: 2,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: BidWinTheme.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextButton(
                onPressed: onBidPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Bid Now',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Buy Now Slider (right, yellow)
          Expanded(
            flex: 3,
            child: _BuyNowSlider(
              currentPrice: currentPrice,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyNowSlider extends StatefulWidget {
  const _BuyNowSlider({
    required this.currentPrice,
  });

  final double currentPrice;

  @override
  State<_BuyNowSlider> createState() => _BuyNowSliderState();
}

class _BuyNowSliderState extends State<_BuyNowSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _snapBackAnimation;
  double _sliderPosition = 0.0;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _snapBackAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _snapBackAnimation.addListener(() {
      if (mounted && !_isCompleted) {
        setState(() {
          _sliderPosition = _snapBackAnimation.value;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isCompleted) return;

    // Stop any ongoing animation
    if (_controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }

    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    
    final double width = box.size.width;
    final double delta = details.delta.dx;
    
    // Calculate thumb width dynamically (approximate based on content)
    final thumbWidth = 200.0; // Approximate width of the yellow pill

    setState(() {
      _sliderPosition = (_sliderPosition + delta).clamp(0.0, width - thumbWidth);
      
      // Check if slider reached the end (with some threshold)
      if (_sliderPosition >= width - thumbWidth - 10) {
        _isCompleted = true;
        _handleBuyNow();
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isCompleted) return;

    // Snap back if not completed
    final startPosition = _sliderPosition;
    _snapBackAnimation = Tween<double>(begin: startPosition, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.forward(from: 0.0).then((_) {
      if (mounted) {
        _controller.reset();
      }
    });
  }

  void _handleBuyNow() {
    final estimatedPrice = widget.currentPrice * 1.1;
    
    // TODO: Handle buy now action - submit purchase
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BidWinTheme.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Purchase successful!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'est. \$${estimatedPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _sliderPosition = 0.0;
                _isCompleted = false;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final estimatedPrice = widget.currentPrice * 1.1;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F26),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          // Background chevrons (visible when slider is not covering)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withOpacity(0.3),
                    size: 18,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.white.withOpacity(0.3),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          // Slider thumb (yellow pill with text and price)
          Positioned(
            left: _sliderPosition,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEB3B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buy Now',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'est. \$${estimatedPrice.toStringAsFixed(2)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black87,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                          size: 18,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BidDialog extends StatefulWidget {
  const _BidDialog({
    required this.currentPrice,
    required this.onBidSubmitted,
  });

  final double currentPrice;
  final VoidCallback onBidSubmitted;

  @override
  State<_BidDialog> createState() => _BidDialogState();
}

class _BidDialogState extends State<_BidDialog> {
  final _bidAmountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bidAmountController.text = widget.currentPrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _bidAmountController.dispose();
    super.dispose();
  }

  void _submitBid() {
    if (_formKey.currentState!.validate()) {
      final bidAmount = double.tryParse(_bidAmountController.text);
      if (bidAmount != null && bidAmount >= widget.currentPrice) {
        // TODO: Submit bid to backend
        widget.onBidSubmitted();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Bid amount must be at least \$${widget.currentPrice.toStringAsFixed(2)}',
            ),
            backgroundColor: BidWinTheme.red,
          ),
        );
      }
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Place a Bid',
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
              Text(
                'Current Bid: \$${widget.currentPrice.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bidAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Bid Amount',
                  hintText: 'Enter bid amount',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bid amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a valid number';
                  }
                  if (amount < widget.currentPrice) {
                    return 'Bid must be at least \$${widget.currentPrice.toStringAsFixed(2)}';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.white.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _submitBid,
                      style: FilledButton.styleFrom(
                        backgroundColor: BidWinTheme.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Submit Bid',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

