// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/components/sign_up_form.dart';
import 'package:myapp/screens/appointment_page.dart';
import 'package:myapp/screens/chat_page.dart';
import 'package:myapp/screens/favorite_page.dart';
import 'package:myapp/screens/home_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: [
          const HomePage(),
          const AppointmentPage(),
          ChatPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 53, 87, 139),
        unselectedItemColor: const Color.fromARGB(255, 53, 87, 139),
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
