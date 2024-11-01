import 'dart:convert';
import 'dart:async'; // Import this for Timer

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:profile_finder/presentation/1ProfileFinder/chat/chat_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  String? userId;
  List<dynamic> chatUser = [];
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print('Loaded user ID: $userId');
    });
    if (userId != null) {
      fetchRelatedList();
      _startPolling();  // Start polling once the userId is available
    } else {
      print('No user ID found');
    }
  }

  Future<void> fetchRelatedList() async {
    if (userId == null) return;

    try {
      final response = await http.get(Uri.parse('http://51.20.61.70:3000/chatting_profile/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != chatUser) { // Check if the data has changed
          setState(() {
            chatUser = data;
            print('Chat users updated: $chatUser');
          });
        } else {
          print('No change in chat users.');
        }
      } else {
        print('Failed to load related list: ${response.statusCode}');
        throw Exception('Failed to load related list');
      }
    } catch (e) {
      print('Error fetching related list: $e');
    }
  }

  void _startPolling() {
    _pollingTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      print('Polling for updates...');
      fetchRelatedList();
    });
  }

  @override
  Widget build(BuildContext context) {
     var heigh = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 255, 1),
      body: ListView.separated(
        itemCount: chatUser.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ChatScreen(
                    usersID: chatUser[index]['uid'].toString(),
                    userName: chatUser[index]['name'].toString(),
                    userProfile: chatUser[index]['profile_picture'].toString(),
                  );
                }),
              ),
              child: Container(
                
                height: 120,
                width: wid*0.9,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          chatUser[index]['profile_picture'].toString(),
                        ),
                      ),
                      SizedBox(width: 15),
                      SizedBox(
                        height: 120,
                        width: wid*0.3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              chatUser[index]['name'].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              chatUser[index]['origin'].toString(),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15),
                      CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xffE5E5E5),
        ),
      ),
    );
  }
}
