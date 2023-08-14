import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black87,
      backgroundColor: Colors.tealAccent[400],
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
          ),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 22,
          ),
          label: 'Favoriler',
        ),
      ],
    );
  }
}
