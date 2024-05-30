//   int genderadio = -1;
//   List<dynamic> chatData = [];
// 
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
// 
//   void fetchData() async {
//     List<dynamic> data = await ApiInstance.getMyChat();
//     // print(data);
//     setState(() {
//       chatData = data;
//     });
//   }
// 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const Center(
//               child: Text(
//                 'Chit Chat',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             // Container(
//             // padding: const EdgeInsets.all(16),
//             // color: const Color.fromARGB(255, 255, 255, 255),
// //               margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
// //
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
//             // children: [
// 
//             // ],
//             // ),
//             // ),
// 
//             Expanded(
//               child: ListView.builder(
//                 itemCount:
//                     chatData.length, // Replace with the desired number of items
//                 itemBuilder: (context, index) {
//                   Map<String, dynamic> item = chatData[index];
//                   String message = item['message'];
//                   bool isOutgoing = item['type'] == 'outgoing';
//                   return Row(
//                     mainAxisAlignment: isOutgoing
//                         ? MainAxisAlignment.end
//                         : MainAxisAlignment.start,
//                     children: [
//                       // isOutgoing
//                       //     ? const Text('')
//                       //     : Image.network(
//                       //         'https://cdn-icons-png.flaticon.com/512/149/149071.png',
//                       //         width: 50,
//                       //       ),
//                       Container(
//                         padding: const EdgeInsets.all(15),
//                         margin: const EdgeInsets.only(left: 5),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                         ),
//                         child: Flexible(
//                           fit: FlexFit.loose,
//                           child: Container(
//                             constraints: BoxConstraints(
//                                 maxWidth:
//                                     MediaQuery.of(context).size.width * 0.6),
//                             child: Text(
//                               message,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       )),
//     );