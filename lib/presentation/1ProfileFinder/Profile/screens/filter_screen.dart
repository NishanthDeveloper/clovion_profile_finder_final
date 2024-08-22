import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  dynamic responseData;

  Future<void> postPreference() async {
    final url = Uri.parse('http://51.20.61.70:3000/saved_search/MWOJGKTCQ71');

    final body = {
      'tag':'tagtest',
      'country': 'india',
      'city': 'madurai',
      'age': '10',
      'complexion': 'Medium',
      'gender': 'Male',
      'denomination': 'Hindu',

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
    return  Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromRGBO(239, 237, 255, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(onPressed: (){
              postPreference();
            }, child: Text("Test")),
          )
        ],
      ),
    );
  }
}