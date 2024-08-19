// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  String? messageContent;
  String? messageType;
  ChatScreen({
    Key? key,
    this.messageContent,
    this.messageType,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatScreen> messages = [
    ChatScreen(messageContent: "Hello, Will", messageType: "receiver"),
    ChatScreen(messageContent: "How have you been?", messageType: "receiver"),
    ChatScreen(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatScreen(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatScreen(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Chat with Brooklyn",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                bool isResceiver = messages[index].messageType == "receiver";
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment:
                        (isResceiver ? Alignment.topLeft : Alignment.topRight),
                    child: Row(
                      mainAxisAlignment: isResceiver
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (isResceiver) ...[
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage(
                                "assets/images/portrait-young-handsome-man-buttoning-his-jacket 1.png"),
                          ),
                        ],
                        const SizedBox(
                          width: 14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isResceiver
                                ? const Color.fromARGB(255, 238, 238, 238)
                                : Color.fromARGB(255, 123, 97, 255),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent as String,
                            style: TextStyle(fontSize: 15,color: isResceiver?Colors.black:Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        if (!isResceiver) ...[
                          const CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage(
                                "assets/images/portrait-young-handsome-man-buttoning-his-jacket 1.png"),
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
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {},
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
