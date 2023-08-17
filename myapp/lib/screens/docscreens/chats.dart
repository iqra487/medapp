import 'package:flutter/material.dart';

import 'package:myapp/components/doctor_card.dart';
import 'package:myapp/utils/config.dart';
import 'package:velocity_x/velocity_x.dart';

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

class DocChatPage extends StatefulWidget {
  @override
  _DocChatPageState createState() => _DocChatPageState();
}

class _DocChatPageState extends State<DocChatPage>
    with SingleTickerProviderStateMixin {
  List<String> _chatRequests = [];
  List<String> _allChats = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addChatRequest(String username) {
    setState(() {
      _chatRequests.add(username);
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
                    return UserChatCard();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserChatCard extends StatelessWidget {
  const UserChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      height: 100,
      child: GestureDetector(
          child: Card(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set border radius
          // side: BorderSide(color: Colors.grey),
        ),
        elevation: 2,
        color: Colors.white,
        child: ListTile(
          title: "Username".text.xl.bold.make(),
          trailing: "11:59AM".text.sm.make(),
          subtitle: "okay, thanks".text.medium.make(),
        ),
      )),
    );
  }
}
