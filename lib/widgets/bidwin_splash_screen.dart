import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class BidWinSplashScreen extends StatelessWidget {
  const BidWinSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: BidWinTheme.red,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 18),
                    blurRadius: 36,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Image.asset(
                'lib/assets/images/bidwin_logo_rv.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'BidWin',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

