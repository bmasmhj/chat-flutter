import 'package:blog/screens/Home/home.dart';
import 'package:blog/utils/api.dart';
import 'package:flutter/material.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({super.key, required this.id});
  final String id;
  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  List<dynamic> recentChats = [];
  late int _id = int.parse(widget.id);
  @override
  void initState() {
    super.initState();
    fetchData();
    _id = int.parse(widget.id);
  }

  Future<void> fetchData() async {
    var fetchdata = {'sender': _id};
    List<dynamic> data =
        await ApiInstance.post('/message/recentMessages', fetchdata);
    setState(() {
      recentChats = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: recentChats.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = recentChats[index];
          var message = item['content'];
          var name = item['receiver_name'];
          int senderId = item['sender_id'];
          int myId = 1;
          return ListTile(
            leading: Image.network(
              'https://cdn-icons-png.flaticon.com/512/149/149071.png',
              width: 50,
              height: 50,
            ),
            trailing: Text(
              '10:2$index',
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            subtitle: Text(truncateString(
                senderId == myId ? 'You : $message' : message, 5)),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
