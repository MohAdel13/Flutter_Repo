import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtomNavigationBar extends StatelessWidget {
  void Function(int)? onTap;
  final int currentIndex;

  CustomButtomNavigationBar({
    this.onTap,
    required this.currentIndex
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.message),
            label: 'Chats'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.squarePlus),
            label: 'Post'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            label: 'Users'
        ),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear),
            label: 'Settings'
        ),
      ],

    );
  }
}
