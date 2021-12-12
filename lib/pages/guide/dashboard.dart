import 'package:flutter/material.dart';
import 'package:tourismapp/pages/guide/navpages/bookings.dart';
import 'package:tourismapp/pages/profile.dart';

import 'navpages/home.dart';

class GuideDashbboardPage extends StatefulWidget {
  const GuideDashbboardPage({Key? key}) : super(key: key);

  @override
  _GuideDashbboardPageState createState() => _GuideDashbboardPageState();
}

class _GuideDashbboardPageState extends State<GuideDashbboardPage> {
  List pages = [
    GuideHomePage(),
    GuideBookingsPage(),
    ProfilePage(),
  ];
  int cIndex = 0;

  void onTapButton(int index) {
    setState(() => cIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[cIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: onTapButton,
        currentIndex: cIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.blueGrey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(label: "Trips", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Bookings", icon: Icon(Icons.notifications)),
          // BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}