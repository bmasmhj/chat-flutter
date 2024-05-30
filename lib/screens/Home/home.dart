import 'package:auto_route/annotations.dart';
import 'package:blog/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'online_users.dart';
import 'recent_chats.dart';

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageStat();
}

class _MyHomePageStat extends State<MyHomePage> {
  List<dynamic> users = [];
  final storage = const FlutterSecureStorage();
  String? id = '';
  @override
  void initState() {
    super.initState();
    fetchVal();
  }

  void fetchVal() async {
    id = await storage.read(key: 'id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Messages',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.6,
          ).copyWith(
            color: AppColors.kGreyScale900,
          ),
        ),
        leading:
            IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
        actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.add))],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        shape: const CircleBorder(),
        child: const Icon(Icons.auto_awesome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Recents',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const OnlineUsers(),
          const SizedBox(height: 15),
          RecentChats(
            id: id ?? '',
          )
        ]),
      ),
    );
  }
}

String truncateString(String text, int maxWords) {
  List<String> words = text.split(' ');

  if (words.length <= maxWords) {
    return text;
  } else {
    return '${words.sublist(0, maxWords).join(' ')}...';
  }
}
