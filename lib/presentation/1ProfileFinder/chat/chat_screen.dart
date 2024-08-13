import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          "Chat wIth Brooklyn",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 708,
              // color: Colors.indigo,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(
                                  "assets/images/portrait-young-handsome-man-buttoning-his-jacket 1.png"),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Container(
                              height: 45,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: const Color(0xff7B61FF),
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                child: Text(
                                  "Hello",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.near_me_rounded,
                        color: Color.fromRGBO(123, 97, 255, 1),
                        size: 35,
                      )),
                  hintText: "Text Your Message Here..",
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
            )
          ],
        ),
      ),
    );
  }
}
