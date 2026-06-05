import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.person, color: Colors.white)),
            title: Text('Coach Mike', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text('When can you hop on a call?', style: TextStyle(color: Colors.white54)),
            trailing: Text('2m ago', style: TextStyle(color: Colors.white54, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
