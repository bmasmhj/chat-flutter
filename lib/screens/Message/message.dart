import 'package:auto_route/annotations.dart';
import 'package:blog/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:blog/utils/api.dart';

@RoutePage()
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final String serverUrl = 'https://api.sunaguthi.com/';
  late io.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<dynamic> messages = [];

  //   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//

  @override
  void initState() {
    super.initState();
    fetchData();
    // Initialize and connect to the socket server.
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Event listeners.
    socket.onConnect((_) {});

    socket.onDisconnect((_) {});

    socket.on('dm-message', (data) {
      setState(() {
        Map<String, dynamic> newdata = {
          ...data,
          'message': data['message'],
          'content': data['message'],
          'sender_id': data['sender'],
          'timestamp': DateTime.now().toString()
        };
        messages.add(newdata);
      });
    });
  }

  void fetchData() async {
    var fetchdata = {"sender": 1, "receiver": 2};
    List<dynamic> data =
        await ApiInstance.post('/message/dmMessage', fetchdata);
    setState(() {
      messages = data;
    });
  }

  // Function to send a message to the server.
  void sendMessage() {
    String message = messageController.text;
    if (message.isNotEmpty) {
      var data = {
        "sender": 1,
        "receiver": 2,
        "message": message,
        "content": message,
        "sender_id": 1,
        "timestamp": DateTime.now().toString()
      };

      socket.emit(
        'dm-message',
        data,
      );

      setState(() {
        messages.add(data);
      });

      messageController.clear();
    }
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Chippi',
              style: GoogleFonts.urbanist(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.6,
              ).copyWith(
                color: AppColors.kGreyScale900,
              ),
            )
          ],
        ),
        leading: IconButton(
            onPressed: () => {}, icon: const Icon(Icons.chevron_left)),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.call_rounded)),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.videocam_off))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount:
                    messages.length, // Replace with the desired number of items
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = messages[index];
                  String message = item['content'];
                  // int receiver_id = item['receiver_id'];
                  int senderId = item['sender_id'];
                  dynamic timeAgo = item['timestamp'];
                  int userId = 1;
                  return Column(
                    crossAxisAlignment: userId == senderId
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: userId == senderId
                                ? Color.fromARGB(255, 15, 163, 231)
                                : Color.fromARGB(255, 233, 233, 233)),
                        // child: Text(message),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          child: Text(
                            message,
                            style: TextStyle(
                              color: userId == senderId
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
