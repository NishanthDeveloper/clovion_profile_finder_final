import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile/screens/edit_filter.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile/screens/filter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedSearchScreen extends StatefulWidget {
  const SavedSearchScreen({super.key});

  @override
  State<SavedSearchScreen> createState() => _SavedSearchScreenState();
}

class _SavedSearchScreenState extends State<SavedSearchScreen> {
  @override
  void initState() {
    loadUserId();
    // TODO: implement initState
    super.initState();
  }
  String? userId;
  List<dynamic> savedSearch = [];
  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    if (userId != null) {
fetchSavedSearch();
    }
  }

  Future<void> fetchSavedSearch() async {
    try {
      print("User ID for Favourites:${userId}");
      final response = await http
          .get(Uri.parse('http://51.20.61.70:3000/saved_search/${userId}'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);
        setState(() {
         savedSearch = (data[userId] as List);
        });
      } else {
        print('Failed to load favorites: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }
    print("Length of data ${savedSearch.length}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 237, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 237, 255, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Save Search",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${savedSearch.length} Saved Preference Available",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(110, 113, 122, 1)),
                    ),
                  ],
                ),
                // filter Button
                InkWell(
                  onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return FilterScreen();
                          }),
                        );
                  },
                  child: Container(
                    height: 38,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(123, 97, 255, 1), width: 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Add",
                          style:
                              TextStyle(color: Color.fromRGBO(123, 97, 255, 1)),
                        ),
                        Image.asset("assets/images/women-fill.png")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 17,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: savedSearch.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14, top: 17),
                                child: Container(
                                  height: 100,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(123, 97, 255, 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    "assets/images/Folder.png",
                                    height: 42,
                                    width: 42,
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    savedSearch[index]['tag'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text("0 Profiles"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditFilterScreen()));
                    },
                                        child: Container(
                                          height: 35,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(123, 97, 255, 0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "EdIt",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      123, 97, 255, 1)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 97,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    123, 97, 255, 1),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "View Profiles",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      123, 97, 255, 1)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
