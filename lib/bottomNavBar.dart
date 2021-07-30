import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key, this.initialIndex = 1, required this.onIndexChanged})
      : super(key: key);

  int initialIndex = 1;
  final Function(int) onIndexChanged;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final Color primaryColor = Color(0xff2FC4B2);
  final Color inactiveIconColor = Colors.white;
  final Color activeIconColor = Colors.blue;

  late int activeIndex;
  @override
  void initState() {
    super.initState();
    activeIndex = widget.initialIndex;
  }

  void setIndex(int _index) {
    setState(() {
      activeIndex = _index;
    });
    widget.onIndexChanged(activeIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.track_changes_outlined,
              color: inactiveIconColor,
            ),
            activeIcon: Icon(
              Icons.track_changes_outlined,
              color: activeIconColor,
            ),
            label: "Track"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: inactiveIconColor,
            ),
            activeIcon: Icon(
              Icons.home_outlined,
              color: activeIconColor,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: inactiveIconColor,
            ),
            activeIcon: Icon(
              Icons.settings_outlined,
              color: activeIconColor,
            ),
            label: "Settings")
      ],
      backgroundColor: primaryColor,
      fixedColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: activeIndex,
      onTap: setIndex,
    );
  }
}
