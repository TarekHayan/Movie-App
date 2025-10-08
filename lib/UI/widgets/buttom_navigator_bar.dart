import 'package:flutter/material.dart';
import 'package:movie_app/UI/screens/home_page.dart';
import 'package:movie_app/constants/colors.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    Center(
      child: Text(
        "Search Page",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    ),
    Center(
      child: Text(
        "Favorites Page",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    ),
    Center(
      child: Text(
        "Profile Page",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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

  Widget navItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPcolor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: isSelected ? 25 : 35),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
