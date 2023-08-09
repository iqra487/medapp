import 'package:flutter/material.dart';

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
    paint.color = Colors.blue; // Change color based on your needs
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          rect, Radius.circular(20.0)), // Circular border radius
      paint,
    );
  }
}

class ActiveChats extends StatefulWidget {
  @override
  _ActiveChatsState createState() => _ActiveChatsState();
}

class _ActiveChatsState extends State<ActiveChats>
    with SingleTickerProviderStateMixin {
  List<String> _activeChats = [
    'Chat 1',
    'Chat 2',
    'Chat 3',
    'Chat 4',
    'Chat 5'
  ];
  List<String> _allChats = [];
  List<String> _chatbotMessages = [];

  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
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

  void _addChatbotMessage(String message) {
    setState(() {
      _chatbotMessages.add(message);
    });
  }

  List<String> _filteredChats() {
    final String searchTerm = _searchController.text.toLowerCase();
    return _activeChats
        .where((chat) => chat.toLowerCase().contains(searchTerm))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Chats'),
            Tab(text: 'Chatbot'),
          ],
          indicator: CircularTabIndicator(),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
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
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search chats...',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredChats().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredChats()[index]),
                    );
                  },
                ),
              ),
            ],
          ),

          // All Chats Tab
          ListView.builder(
            itemCount: _allChats.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_allChats[index]),
              );
            },
          ),

          // Chatbot Tab
          ListView.builder(
            itemCount: _chatbotMessages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_chatbotMessages[index]),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a new chat or interact with the chatbot based on the selected tab
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
