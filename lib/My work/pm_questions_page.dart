import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PmQuestionsPage extends StatefulWidget {
  const PmQuestionsPage({super.key});

  @override
  State<PmQuestionsPage> createState() => _PmQuestionsPageState();
}

class _PmQuestionsPageState extends State<PmQuestionsPage> {
  List<dynamic> ComplaintsList = [];

  Future<void> fetchComplaintList() async {
    try {
      print("User ID for Favourites:");
      final response = await http.get(Uri.parse('http://51.20.61.70:3000/alldata/APNBGKTCQ73'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);

        // Print the entire JSON response to see its structure
        print('Full JSON response: $data');

        setState(() {
          // Adjust this based on the actual structure of the JSON response
          if (data.containsKey('APNBGKTCQ73') && data['APNBGKTCQ73'] != null) {
            ComplaintsList = List<dynamic>.from(data['APNBGKTCQ73']);
          } else {
            print("Key 'APNBGKTCQ73' is missing or null");
            ComplaintsList = [];  // Assign an empty list if the key is missing or null
          }
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
    fetchComplaintList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: ComplaintsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              ComplaintsList[index]['emergency_name']?.toString() ?? 'No UID',  // Handle null values safely
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
          );
        },
      ),
    );
  }
}
