import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/profile_screen.dart';
import '../screens/fav_screen.dart';
import '../screens/home_page.dart';
import '../screens/search_screen.dart';
import '../../constants/colors.dart';
import '../../helper/responsive_helper.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});
  static String id = 'CustomBottomNav';
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    if (isDesktop) {
      // Desktop/Web: Use NavigationRail
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.black,
              selectedIconTheme: IconThemeData(color: kPcolor, size: 28),
              selectedLabelTextStyle: TextStyle(color: kPcolor, fontSize: 14, fontWeight: FontWeight.bold),
              unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 24),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white70, fontSize: 12),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.house_outlined),
                  selectedIcon: Icon(Icons.house),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: Text('Search'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border_outlined),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Favorite'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_2_outlined),
                  selectedIcon: Icon(Icons.person_2),
                  label: Text('Profile'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: IndexedStack(index: currentIndex, children: pages),
            ),
          ],
        ),
      );
    } else {
      // Mobile/Tablet: Use Bottom Navigation Bar
      return Scaffold(
        body: IndexedStack(index: currentIndex, children: pages),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.getResponsiveVerticalPadding(context),
              horizontal: ResponsiveHelper.getResponsiveHorizontalPadding(context) / 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                navItem(Icons.house, "Home", 0),
                navItem(Icons.search, "Search", 1),
                navItem(Icons.favorite_border_outlined, "Favorite", 2),
                navItem(Icons.person_2_outlined, "Profile", 3),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final touchTargetSize = ResponsiveHelper.getTouchTargetSize(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getResponsiveSpacing(context, mobile: 12, tablet: 15, desktop: 18),
          vertical: ResponsiveHelper.getResponsiveSpacing(context, mobile: 8, tablet: 10, desktop: 12),
        ),
        constraints: BoxConstraints(
          minWidth: touchTargetSize,
          minHeight: touchTargetSize,
        ),
        decoration: BoxDecoration(
          color: isSelected ? kPcolor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isSelected
                  ? ResponsiveHelper.getResponsiveFontSize(context, mobile: 22, tablet: 24, desktop: 26)
                  : ResponsiveHelper.getResponsiveFontSize(context, mobile: 28, tablet: 30, desktop: 32),
            ),
            if (isSelected) ...[
              SizedBox(width: ResponsiveHelper.getResponsiveSpacing(context, mobile: 6, tablet: 8, desktop: 10)),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 13, tablet: 14, desktop: 15),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
