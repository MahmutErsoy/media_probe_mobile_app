import 'package:flutter/material.dart';
import 'package:media_probe_mobile_app/core/constants/colors_constants.dart';

import '../../constants/string_constants.dart';

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
      selectedItemColor: ColorConstants.instance.white,
      unselectedItemColor: ColorConstants.instance.black,
      backgroundColor: ColorConstants.instance.tealAccent,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 25,
          ),
          label: StringConstants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 22,
          ),
          label: StringConstants.favorites,
        ),
      ],
    );
  }
}
