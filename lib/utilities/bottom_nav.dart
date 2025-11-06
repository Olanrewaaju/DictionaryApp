import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/search.dart';
import '../screens/settings.dart';
import '../screens/saved_word_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool valid = true;
  int selectedIndex = 0;

  final List<Widget> pages = [
    const Home(),
    const Search(),
    const SavedWordsScreen(backButt: false),
    const Settings(),
  ];

  void onItemTapped(int index) {
    if (index == 1) {
      // 👇 Instead of switching the index, navigate to a new page (Search)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const Search()),
      );
    } else {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 10, 132, 255),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          BottomNavigationBarItem(
            icon: mounted
                ? Icon(Icons.home, size: 28)
                : Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 28),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark, size: 28),
            label: 'Bookmarked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 28),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
