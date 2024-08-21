// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, must_be_immutable
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_finder/model_final/model_final.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/1screen_advertisement.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  final String? messageContent;
  final String? messageType;
  final String? userName;
  final String? userProfile;
  final String? usersID;

  ChatScreen({
    Key? key,
    this.messageContent,
    this.messageType,
    this.userName,
    this.userProfile,
    this.usersID,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<dynamic> chatMessages = [];
  TextEditingController _messageFieldController = TextEditingController();
  String? userId;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageFieldController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });

    if (userId != null) {
      fetchCurrentUserData();
      fetchChatData();
    }
  }

  Future<void> fetchCurrentUserData() async {
    try {
      print("User ID for Favourites:${userId}");
      final response = await http.get(Uri.parse('http://51.20.61.70:3000/favorites/${userId}'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);
        setState(() {
          // Handle current user details if needed
        });
      } else {
        print('Failed to load favorites: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  Future<void> sendMessage() async {
    // Trim the message to remove any leading/trailing whitespace
    final messageText = _messageFieldController.text.trim();

    // Check if the message is empty
    if (messageText.isEmpty) {
      print('Message is empty. Not sending.');
      return;
    }

    // Define the API endpoint
    final url = 'http://51.20.61.70:3000/chatting/${userId}/${widget.usersID}';

    // Define the body of the POST request
    final body = {
      'sender': userId,
      'msg': messageText,
    };

    // Make the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      print('Message sent successfully');
      _messageFieldController.clear();
      fetchChatData(); // Refresh chat messages after sending a new message
    } else {
      print('Failed to send message. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchChatData() async {
    final url = 'http://51.20.61.70:3000/chat_display/${userId}/${widget.usersID}';
    try {
      print("User ID for Chat: $userId");
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);

        // Parse the chat messages
        List<dynamic> messagesList = data;
        setState(() {
          chatMessages = messagesList;
        });
        print("Chat messages loaded successfully.${chatMessages.length}");

        // Scroll to the bottom after messages are loaded
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      } else {
        print('Failed to load chat data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching chat: $e');
    }
  }

  Users _users = Users();
  bool isLoading = true;
  late String userUid;
  late String nameOfBrideGroom;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userUid = preferences.getString("uid2").toString();
    setState(() {
      nameOfBrideGroom = preferences.getString("nameOfBrideGroom").toString();
    });
    final response = await http
        .get(Uri.parse("http://${ApiService.ipAddress}/alldata/$userUid"));
    var json = jsonDecode(response.body);

    print("statusCodeIs${response.statusCode}");

    if (response.statusCode == 200) {
      _users = Users.fromJson(json);
      print(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      print("error");
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserId();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Chat with ${widget.userName}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: chatMessages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                final messageContent = message.values.first as String;
                final senderId = message.keys.first;
                final isReceiver = senderId == widget.usersID;

                return Container(
                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: isReceiver ? Alignment.topLeft : Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: isReceiver ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if (isReceiver) ...[
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(widget.userProfile ?? ''),
                          ),
                        ],
                        const SizedBox(width: 14),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isReceiver
                                ? const Color.fromARGB(255, 238, 238, 238)
                                : Color.fromARGB(255, 123, 97, 255),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messageContent,
                            style: TextStyle(fontSize: 15, color: isReceiver ? Colors.black : Colors.white),
                          ),
                        ),
                        const SizedBox(width: 14),
                        if (!isReceiver) ...[
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(
                                _users.profilePicture.toString()),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _messageFieldController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.near_me_rounded,
                    color: Color.fromRGBO(123, 97, 255, 1),
                    size: 35,
                  ),
                ),
                hintText: "Text Your Message Here...",
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 226, 251, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(230, 226, 251, 1),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(230, 226, 251, 1),
                focusColor: const Color.fromRGBO(230, 226, 251, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
