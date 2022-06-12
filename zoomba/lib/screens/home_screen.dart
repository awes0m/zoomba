import 'package:flutter/material.dart';
import 'package:zoomba/screens/history_meeting_screen.dart';
import 'package:zoomba/screens/meetings_screen.dart';
import 'package:zoomba/utils/colors.dart';
import 'package:zoomba/utils/utils.dart';
import 'package:zoomba/widgets/custom_neu_button.dart';

import '../resources/auth_methods.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  List<Widget> pages = [
    const MeetingScreen(),
    const HistoryMeetingScreen(),
    const Text('Contacts'),
    Center(
      child: CustomNeuButton(
        buttonWidth: ScrnSizer.screenWidth() * 0.8,
        text: 'Log Out',
        backgroundColor: backgroundColor,
        onPressed: () => AuthMethods().signOut(),
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zoomba!'),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 8,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          backgroundColor: footerColor,
          currentIndex: _currentIndex,
          unselectedIconTheme:
              const IconThemeData(color: secondaryBackgroundColor),
          selectedItemColor: Colors.white,
          onTap: onPageChanged,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock), label: 'Meetings'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body: pages[_currentIndex]);
  }
}
