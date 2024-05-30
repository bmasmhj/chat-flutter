import 'package:blog/utils/api.dart';
import 'package:flutter/material.dart';

class OnlineUsers extends StatefulWidget {
  const OnlineUsers({
    super.key,
  });

  @override
  State<OnlineUsers> createState() => _OnlineUsersState();
}

class _OnlineUsersState extends State<OnlineUsers> {
  List<dynamic> onlineUsers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<dynamic> data = await ApiInstance.get('/users/all');
    setState(() {
      onlineUsers = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: onlineUsers.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> item = onlineUsers[index];
            var name = item['name'];
            return Container(
              margin: const EdgeInsets.only(right: 15),
              // width: 60,
              child: Stack(
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        foregroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/previews/016/776/048/original/a-cute-baby-penguin-dressed-in-a-snow-coat-stands-in-the-snow-du-vector.jpg'),
                        radius: 25,
                      ),
                      Text(name),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    right: 0,
                    child: Container(
                      width: 12, // Adjust size as needed
                      height: 12, // Adjust size as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
