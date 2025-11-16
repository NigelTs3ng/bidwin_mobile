import 'package:flutter/material.dart';

import '../theme/bidwin_theme.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    super.key,
    this.onNavigateToAccount,
    this.onNavigateToFeed,
  });

  final VoidCallback? onNavigateToAccount;
  final VoidCallback? onNavigateToFeed;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedBottomNav = 0;

  // Mock data for categories
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.person, 'label': 'You', 'color': Colors.grey},
    {'icon': Icons.favorite, 'label': 'Followed Hosts', 'color': Colors.yellow},
    {
      'icon': Icons.shopping_bag,
      'label': 'Pokémon Cards',
      'color': Colors.yellow,
      'selected': true
    },
    {'icon': Icons.style, 'label': 'Trading Card Games', 'color': Colors.blue},
    {'icon': Icons.checkroom, 'label': 'Streetwear', 'color': Colors.purple},
  ];

  // Mock data for filter/sort options
  final List<String> _filterOptions = ['Filter', 'Recommended', 'Top Sellers', 'New Arrivals'];
  int _selectedFilter = 1; // Recommended is selected

  // Mock data for live shows
  final List<Map<String, dynamic>> _liveShows = [
    {
      'host': 'pokepluslive',
      'viewers': 58,
      'title': '\$1 MEGA MODERN MORNING W TREP',
      'category': 'Pokémon Cards',
      'description': '\$1 Starts,...',
      'hostLogo': 'vortexcards',
      'logoColor': Colors.purple,
    },
    {
      'host': 'yomommaboy',
      'viewers': 151,
      'title': '\$1-Yuka Morii',
      'category': 'Pokémon Cards',
      'description': 'Vintage, P...',
      'hostLogo': 'traders_shop',
      'logoColor': Colors.blue,
    },
    {
      'host': 'cardcollector',
      'viewers': 89,
      'title': 'Rare Charizard Showcase',
      'category': 'Pokémon Cards',
      'description': 'First Edition,...',
      'hostLogo': 'cardvault',
      'logoColor': Colors.red,
    },
  ];

  void _onBottomNavTap(int index) {
    if (index == 0) {
      // Home - stay on same screen
      setState(() => _selectedBottomNav = 0);
      return;
    } else if (index == 4) {
      // Account - navigate to UserActivityScreen via PageView
      widget.onNavigateToAccount?.call();
    } else {
      // Categories, Sell, Activity - placeholder
      setState(() => _selectedBottomNav = index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${['', 'Categories', 'Sell', 'Activity', 'Account'][index]} coming soon'),
          backgroundColor: BidWinTheme.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: BidWinTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with search and icons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: BidWinTheme.cardBackground,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search slabs',
                          hintStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white54,
                          ),
                          prefixIcon: const Icon(Icons.search, color: Colors.white70),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    color: Colors.white70,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.white70,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.card_giftcard),
                    color: Colors.white70,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Category chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category['selected'] == true;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category['label']),
                      avatar: Icon(
                        category['icon'],
                        size: 18,
                        color: isSelected ? Colors.black : category['color'],
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          for (var cat in _categories) {
                            cat['selected'] = false;
                          }
                          category['selected'] = selected;
                        });
                      },
                      backgroundColor: BidWinTheme.cardBackground,
                      selectedColor: category['color'],
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        color: isSelected ? Colors.black : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  );
                },
              ),
            ),
            // Filter/Sort options
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                itemCount: _filterOptions.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (index == 0) ...[
                            const Icon(Icons.tune, size: 16),
                            const SizedBox(width: 4),
                          ],
                          Text(_filterOptions[index]),
                        ],
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFilter = index;
                        });
                      },
                      backgroundColor: BidWinTheme.cardBackground,
                      selectedColor: Colors.white,
                      labelStyle: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected ? Colors.black : Colors.white70,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // "Shows in your region" heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Shows in your region',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Live shows grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _liveShows.length,
                itemBuilder: (context, index) {
                  final show = _liveShows[index];
                  return _LiveShowCard(
                    show: show,
                    onTap: widget.onNavigateToFeed,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: BidWinTheme.cardBackground,
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItem(
                  icon: Icons.home,
                  label: 'Home',
                  selected: _selectedBottomNav == 0,
                  onTap: () => setState(() => _selectedBottomNav = 0),
                ),
                _BottomNavItem(
                  icon: Icons.search,
                  label: 'Categories',
                  selected: _selectedBottomNav == 1,
                  onTap: () => _onBottomNavTap(1),
                ),
                _BottomNavItem(
                  icon: Icons.add_circle_outline,
                  label: 'Sell',
                  selected: _selectedBottomNav == 2,
                  onTap: () => _onBottomNavTap(2),
                ),
                _BottomNavItem(
                  icon: Icons.favorite_outline,
                  label: 'Activity',
                  selected: _selectedBottomNav == 3,
                  onTap: () => _onBottomNavTap(3),
                ),
                _BottomNavItem(
                  icon: Icons.person_outline,
                  label: 'Account',
                  selected: _selectedBottomNav == 4,
                  onTap: () => _onBottomNavTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LiveShowCard extends StatelessWidget {
  const _LiveShowCard({
    required this.show,
    this.onTap,
  });

  final Map<String, dynamic> show;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: BidWinTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with live badge
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 48,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: BidWinTheme.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Live • ${show['viewers']}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      child: Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Show info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show['title'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${show['category']} • ${show['description']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: (show['logoColor'] as Color).withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              (show['hostLogo'] as String)[0].toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: show['logoColor'] as Color,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          show['hostLogo'],
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? BidWinTheme.red : Colors.white54,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: selected ? BidWinTheme.red : Colors.white54,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

