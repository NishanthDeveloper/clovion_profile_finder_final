import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profile_finder/presentation/1ProfileFinder/chat/chat_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(244, 242, 255, 1),
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () =>  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ChatScreen();
                          }),
                        ),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                              "assets/images/portrait-young-handsome-man-buttoning-his-jacket 1.png"),
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
                                "Brooklyn Simmons",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Algerian",
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
