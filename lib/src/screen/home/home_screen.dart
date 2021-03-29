import 'package:client_delivery_app/src/components/home/drawer_widget.dart';
import 'package:client_delivery_app/src/components/home/home_wiget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      HomeWidget(),
      // SearchScreen(context, false),
      Text(
        'Index 2: School',
      ),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: const Color(0xFFF9F9F9),
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        onTap: _onItemTapped,
      ),
    );
  }
}
