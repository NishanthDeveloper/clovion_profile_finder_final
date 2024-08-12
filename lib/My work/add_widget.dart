import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddWidget extends StatefulWidget {
  final String imageUrl;
  final Map<String, dynamic> adData;
  final Set<String> postedAdIds; // Add a Set to track posted ad IDs

  AddWidget({super.key, required this.imageUrl, required this.adData, required this.postedAdIds});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  showAdPopup(widget.adData);
                },
                child: CachedNetworkImage(
                  height: 216,
                  width: 162,
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAdPopup(Map<String, dynamic> ad) {
    postAdViewCount(ad);
    print("showAdPopup called with ad: ${widget.adData}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ad Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.imageUrl, height: 500, width: 500, fit: BoxFit.cover),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> postAdViewCount(Map<String, dynamic> ad) async {
    String apiUrl;
    String adsId;

    if (ad['distributor'] != null) {
      apiUrl = 'http://51.20.61.70:3000/disads_views_count/APNBGKTCQ73';
      adsId = ad['distributor']['ad_id'];
    } else if (ad['provider'] != null) {
      apiUrl = 'http://51.20.61.70:3000/proads_views_count/APNBGKTCQ73';
      adsId = ad['provider']['ad_id'];
    } else {
      return;
    }

    // Check if the ad ID has already been posted
    if (widget.postedAdIds.contains(adsId)) {
      print('View count already posted for this ad');
      return;
    }

    // Prepare the data for the POST request
    final data = {
      'ads_id': adsId,
      'views_count': "1",
    };

    // Send the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('View count posted successfully');
      // Add the ad ID to the set of posted ad IDs
      widget.postedAdIds.add(adsId);
    } else {
      print('Failed to post view count');
    }
  }
}