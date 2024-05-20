import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  const BottomNavigation({super.key, required this.selectedIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex = widget.selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black87,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
        BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Tv shows'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/movies');
            break;
          case 1:
            Navigator.pushNamed(context, '/tv_shows');
            break;
          case 2:
            Navigator.pushNamed(context, '/watchlist');
            break;
          default:
            break;
        }
      }
    );
  }
}