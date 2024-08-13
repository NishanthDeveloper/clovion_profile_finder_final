import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<Map<String, dynamic>>> notifications;
  late String userId;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchNotifications();
  }

  Future<void> _loadUserIdAndFetchNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("uid2") ?? '';

    if (userId.isNotEmpty) {
      setState(() {
        notifications = fetchNotifications(userId);
      });
    } else {
      setState(() {
        notifications = Future.value([]); // Empty list or handle appropriately
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchNotifications(String userId) async {
    final response = await http.get(Uri.parse('http://51.20.61.70:3000/notification_data/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => json as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> _deleteNotification(String notificationId) async {
    final response = await http.post(
      Uri.parse('http://51.20.61.70:3000/delete_all_notification/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'notify_id': notificationId, // Adjust the body according to your API specification
      }),
    );

    if (response.statusCode == 200) {
      // Successfully deleted, now refresh the notifications list
      setState(() {
        notifications = fetchNotifications(userId);
      });
    } else {
      throw Exception('Failed to delete notification');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar:      AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No notifications available.',
                    style: TextStyle(color: Colors.grey)));
          } else {
            final notifications = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        String notificationId = notification['notify_id']; // Assuming 'id' is the field name
                        await _deleteNotification(notificationId);
                      },
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      notification['not_message'] ?? 'No Message',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      notification['notify_date'] ?? 'No Date',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
