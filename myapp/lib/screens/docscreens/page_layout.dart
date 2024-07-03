import 'package:flutter/material.dart';

import '../appointment_page.dart';
import 'chats.dart';
import 'doc_appointment.dart';
import 'doc_profile.dart';

class DocMainLayout extends StatefulWidget {
  const DocMainLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<DocMainLayout> createState() => _DocMainLayoutState();
}

class _DocMainLayoutState extends State<DocMainLayout> {
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
        children: [const AppointmentPage(), DocChatPage(), DocProfile()],
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Appointments',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
