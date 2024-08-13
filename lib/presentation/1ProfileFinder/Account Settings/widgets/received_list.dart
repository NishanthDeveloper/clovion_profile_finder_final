import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReceivedListWidget extends StatefulWidget {
  String status;

  ReceivedListWidget({super.key, required this.status});

  @override
  State<ReceivedListWidget> createState() => _ReceivedListWidgetState();
}

class _ReceivedListWidgetState extends State<ReceivedListWidget> {
  String? userId;
  List<dynamic> received_List = [];

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    if (userId != null) {
      fetchreceivedlist();
    }
  }

  Future<void> fetchreceivedlist() async {
    try {
      print("User ID for Favourites:${userId}");
      final response = await http
          .get(Uri.parse('http://51.20.61.70:3000/received_list/${userId}'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);
        setState(() {
          received_List = (data[userId] as List);
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

  @override
  void initState() {
    loadUserId();
    // TODO: implement initState
    super.initState();
  }

  void accept(String action,String uid) async {
    var url = Uri.parse('http://51.20.61.70:3000/received_list/$userId'); // Replace with your API endpoint

    var data = {
      'uid': uid, // Notice how the list brackets are removed
      'action': action
    };

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: data, // Data is sent as form data, not JSON encoded
    );

    if (response.statusCode == 200) {
      print('Success: ${response.body}');
      Navigator.pop(context);
    } else {
      print('Failed: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return received_List != null
        ? ListView.builder(
            itemCount: received_List.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      // StackContainer
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(14),
                            child: Container(
                              height: 140,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        received_List[index]
                                                ['profile_picture'] ??
                                            ''.toString(),
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xffDBFFEA)),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_downward,
                                  size: 16,
                                  color: Color(0xff6FCF97),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          height: 140,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                received_List[index]['name'] ?? ''.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                received_List[index]['address'] ??
                                    ''.toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                    color: widget.status == "Accepteds"
                                        ? Color.fromRGBO(242, 153, 74, 0.2)
                                        : Color.fromRGBO(123, 97, 255, 0.2),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: received_List[index]
                                  ['action'] .toString() == null ? Text(
                                    "Request",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: widget.status == "Accepteds"
                                          ? Color.fromRGBO(242, 153, 74, 1)
                                          : Color.fromRGBO(123, 97, 255, 1),
                                    ),
                                  ): Text(
                                    received_List[index]
                                    ['action'] .toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: widget.status == "Accepteds"
                                          ? Color.fromRGBO(242, 153, 74, 1)
                                          : Color.fromRGBO(123, 97, 255, 1),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          // Align the buttons to the bottom
                          children: [
                            GestureDetector(
                              onTap: () {
                                accept( 'reject',received_List[index]
                                ['uid'] ??
                                    ''.toString(),);
                              },
                              child: Container(
                                height: 45,
                                width: 86,
                                decoration: BoxDecoration(
                                    color: Color(0xffE5E5E5),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      color: Color(0xff6E717A),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                accept( 'accept',received_List[index]
                                ['uid'] ??
                                    ''.toString(),);
                              },
                              child: Container(
                                height: 45,
                                width: 86,
                                decoration: BoxDecoration(
                                    color: Color(0xff7B61FF),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "No Request Available",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black54),
            ),
          );
  }
}
