import 'package:flutter/material.dart';

import 'package:myapp/components/doctor_card.dart';
import 'package:myapp/utils/config.dart';

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ChatPage(),
//     );
//   }
// }

class CircularTabIndicator extends Decoration {
  @override
  _CircularPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CircularPainter(this);
  }
}

class _CircularPainter extends BoxPainter {
  final CircularTabIndicator decoration;

  _CircularPainter(this.decoration);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Rect.fromLTWH(offset.dx, offset.dy,
        configuration.size!.width, configuration.size!.height);
    final Paint paint = Paint();
    paint.color = const Color.fromARGB(
        255, 251, 252, 252); // Change color based on your needs
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, Radius.circular(20.0)), // Circular border radius
      paint,
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  List<String> _activeChats = [];
  List<String> _allChats = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addActiveChat(String message) {
    setState(() {
      _activeChats.add(message);
    });
  }

  void _addAllChat(String message) {
    setState(() {
      _allChats.add(message);
    });
  }

  // void _addChatbotMessage(String message) {
  //   setState(() {
  //     _chatbotMessages.add(message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          // indicatorWeight: 2.0,
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Active',
            ),
            Tab(text: 'Chats'),
          ],
          indicator: CircularTabIndicator(),
          labelColor: Config.primaryColor,
          unselectedLabelColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Chats Tab with Search
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search chats...',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _activeChats.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_activeChats[index]),
                    );
                  },
                ),
              ),
            ],
          ),
          // All Chats Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search chats...',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return DoctorChatCard(route: 'doc_details');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.grey[100],
        onPressed: () {
          // Open a new chat or interact with the chatbot based on the selected tab
        },
        label: Text(
          'Chatbot',
          style: TextStyle(color: Config.primaryColor),
        ),
        icon: Image.asset(
          'assets/animations/robot-icons.ico',
          width: 30,
          height: 30,
        ),
      ),
    );
  }
}
