import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class requestedListView extends StatefulWidget {
  String status;

  requestedListView({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<requestedListView> createState() => _requestedListViewState();
}

class _requestedListViewState extends State<requestedListView> {
  String? userId;
  List<dynamic> requested_List = [];

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    if (userId != null) {
      fetchrequestedlist();
    }
  }

  Future<void> fetchrequestedlist() async {
    try {
      print("User ID for Favourites:${userId}");
      final response = await http
          .get(Uri.parse('http://51.20.61.70:3000/requested_list/${userId}'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);
        setState(() {
          requested_List = (data[userId] as List);
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
  @override
  Widget build(BuildContext context) {
    var heigh = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.height;

    return ListView.builder(
      itemCount: requested_List.length,
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
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: 140,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                            image:  DecorationImage(
                                image: NetworkImage(
                                  requested_List[index]
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
                            color: Color.fromRGBO(255, 239, 225, 1)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 16,
                            color: Color(0xffF2994A),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 140,
                  width: wid*0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        requested_List[index]['name'] ?? ''.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        requested_List[index]['address'] ?? ''.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: requested_List[index]['action'].toString() == 'accept'
                                ? Color(0xff6FCF97).withOpacity(0.1):Color.fromRGBO(242, 153, 74, 0.2)
                                 ,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            requested_List[index]['action'] == 'accept' ? 'Accepted' : "Rejected",
                            style: TextStyle(
                              fontSize: 12,
                              color: requested_List[index]['action'].toString() == 'accept'
                                  ? Color(0xff27AE60)
                                  :Color.fromRGBO(242, 153, 74, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Column(
                  children: [
                     SizedBox(
                              height: 10,
                            ),
                    Container(
                        height: 120,
                        //   color: Colors.deepOrange,
                        child: Column(
                          children: [
                             Container(
                                height: heigh*0.06,
                                width: wid*0.09,
                                decoration: BoxDecoration(
                                    color: Color(0xff27AE60),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                           requested_List[index]['action'] != 'empty' ? requested_List[index]['action'].toString().toUpperCase() : "Pending",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                ),
                              ),
                               SizedBox(
                              height: 10,
                            ),
                             Container(
                               height: heigh*0.06,
                                width: wid*0.09,
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
                           
                           
                            // Container(
                            //   height: 50,
                            //   width: 120,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         image: AssetImage(
                            //           "assets/images/rect_green.png",
                            //         ),
                            //       )),
                            //   child: Stack(
                            //     children: [
                            //       Positioned(
                            //         child: Center(
                            //           child: Row(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               SizedBox(
                            //                 width: 0.5,
                            //               ),
                            //               Image.asset('assets/images/hand.png'),
                            //              Text(
                            //                requested_List[index]['action'] != 'empty' ? requested_List[index]['action'].toString().toUpperCase() : "Pending",
                            //                 style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   height: 50,
                            //   width: 120,
                            //   decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //         image: AssetImage(
                            //           "assets/images/rect_grey.png",
                            //         ),
                            //       )),
                            //   child: Stack(
                            //     children: [
                            //       Positioned(
                            //         child: Center(
                            //           child: Row(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.spaceEvenly,
                            //             children: [
                            //               SizedBox(
                            //                 width: 0.5,
                            //               ),
                            //               Image.asset(
                            //                   'assets/images/cancel.png'),
                            //               Text(
                            //                 'Cancel',
                            //                 style: TextStyle(
                            //                   color: Color(0xff6E717A),
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        )),
                  ],
                ),
               
              ],
            ),
          ),
        );
      },
    );
  }
}
