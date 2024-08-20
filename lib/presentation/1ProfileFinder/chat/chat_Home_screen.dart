import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_finder/presentation/1ProfileFinder/chat/chat_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  String? userId;
  List<dynamic> chatUser = [];

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
      fetchRelatedList();
    });
  }

  @override
  void initState() {
    super.initState();

    loadUserId();
  }

  Future<void> fetchRelatedList() async {
    final response = await http
        .get(Uri.parse('http://51.20.61.70:3000/chatting_profile/${userId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        chatUser = data;
      });
    } else {
      throw Exception('Failed to load related list');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    return ChatScreen();
                  }),
                ),
                child: Container(
                  height: 120,
                  width: double.infinity,
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
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 120,
                          width: 260,
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
                        SizedBox(
                          width: 15,
                        ),
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
        ));
  }
}
