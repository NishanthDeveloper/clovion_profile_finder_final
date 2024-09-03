import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({super.key});

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  List<dynamic> blockedUsers = [];
  bool isLoading = true;
  String? userId;

  Future<void> getUserIdFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
    });
    if (userId != null) {
      fetchBlockedUsers(userId!);
    }
  }

  Future<void> fetchBlockedUsers(String userId) async {
    final response = await http.get(
      Uri.parse('http://51.20.61.70:3000/block/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        blockedUsers = data[userId] ?? [];
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      print('Failed to load blocked users');
    }
  }

  Future<void> unBlock(String unBlockedId, String userUid1) async {
    debugPrint('UnBlock Start');

    var requestBody = {
      'unblock': unBlockedId,
    };

    var responseUnb = await http.post(
      Uri.parse("http://51.20.61.70:3000/block/$userUid1"),
      body: requestBody,
    );

    debugPrint("statusCodeIs${responseUnb.statusCode}");

    if (responseUnb.statusCode == 200) {
      print(responseUnb.body);
      debugPrint("Unblocked successfully");
      Navigator.pop(context);
      // Refresh the list of blocked users after successful unblocking
      fetchBlockedUsers(userUid1);
    } else {
      print("error");
      print(responseUnb.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserIdFromSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blocked Accounts",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : blockedUsers.isEmpty
          ? Center(
        child: Text(
          "No blocked users",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
          : ListView.builder(
        itemCount: blockedUsers.length,
        itemBuilder: (context, index) {
          final user = blockedUsers[index];
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      user['profile_picture'] ?? '') as ImageProvider,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] ?? 'Unknown User',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        user['origin'] ?? 'Unknown Origin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (userId != null) {
                      unBlock(user['uid'], userId!);
                      print('Blocked users uid:${
                          user['uid'].toString()}');
                      }
                      },
                  child: Text(
                    "Unblock",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
