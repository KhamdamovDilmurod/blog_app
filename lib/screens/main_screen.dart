import 'package:blog_app/screens/fav_screen/favotites_screen.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavotitesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
