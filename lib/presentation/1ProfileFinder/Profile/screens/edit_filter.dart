import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../MatchingList/1screen_advertisement.dart';

class EditFilterScreen extends StatefulWidget {
  const EditFilterScreen({super.key});

  @override
  State<EditFilterScreen> createState() => _EditFilterScreenState();
}

class _EditFilterScreenState extends State<EditFilterScreen> {
  TextEditingController tagName = TextEditingController();
  TextEditingController age = TextEditingController();

  String? genderSeletedValue;

  List<DropdownMenuItem<String>> get gender {
    return [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
      const DropdownMenuItem(value: "Others", child: Text("Others")),
    ];
  }
   String? userId;
  List<dynamic> savedSearch = [];

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    // if (userId != null) {
    //   fetchSavedSearch();
    // }
  }

  void genderselectedValueChange(String? newValue) {
    setState(() {
      genderSeletedValue = newValue;
    });
  }
  String? denominationSeletedValue;

  List<DropdownMenuItem<String>> get denomination {
    return [
      const DropdownMenuItem(value: "Hindu", child: Text("Hindu")),
      const DropdownMenuItem(value: "christian", child: Text("christian")),
      const DropdownMenuItem(value: "Muslim", child: Text("Muslim")),
    ];
  }

  void denominationselectedValueChange(String? newValue) {
    setState(() {
     denominationSeletedValue = newValue;
    });
  }
  dynamic responseData;

  Future<void> postPreference() async {
    final url = Uri.parse('http://${ApiService.ipAddress}/saved_search/$userId');

    final body = {
      'tag': tagName.text,
      'country': 'india',
      'city': 'madurai',
      'age': '10',
      'complexion': 'Medium',
      'gender': 'Male',
      'denomination': 'Hindu',
      'tag_edit': '',
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Preference posted successfully');
        // Decode the response and handle both Map and List cases
        final decodedResponse = json.decode(response.body);
        setState(() {
          responseData = decodedResponse;
        });
      } else {
        print('Failed to post preference: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error posting preference: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromRGBO(239, 237, 255, 1),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tag Name*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: tagName,
                  decoration: InputDecoration(
                      hintText: "Enter Your Tag Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Country"),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("City"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Age*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                      hintText: "Enter Your Age",
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Skin*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Dark"),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Medium"),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Moderate Fair"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Fair"),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text("Very Fair"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Gender*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                      height: 54,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide:
                                BorderSide(width: 0, color: Colors.black26),
                          ),
                        ),
                        items: gender,
                        value: genderSeletedValue,
                        onChanged: genderselectedValueChange,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Denomination*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                      height: 54,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide:
                                BorderSide(width: 0, color: Colors.black26),
                          ),
                        ),
                        items: denomination,
                        value:denominationSeletedValue,
                        onChanged: genderselectedValueChange,
                      )),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(43, 68, 204, 1),
                        Color.fromRGBO(228, 135, 243, 1),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  postPreference();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(43, 68, 204, 1),
                        Color.fromRGBO(228, 135, 243, 1),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
