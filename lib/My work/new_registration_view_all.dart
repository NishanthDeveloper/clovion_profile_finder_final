import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:profile_finder/My%20work/user_card_widget.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/Id123456FiftyScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Registeration/3ScreenSignin.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class NewRegistrationPage extends StatefulWidget {
  const NewRegistrationPage({super.key});

  @override
  State<NewRegistrationPage> createState() => _NewRegistrationPageState();
}

class _NewRegistrationPageState extends State<NewRegistrationPage>  {

  int _current = 0;
  List<dynamic> users = [];
  List<Map<String, dynamic>> adData = [];
  final Set<String> postedAdIds = {};
  String? userId;
  List<dynamic> favoriteUsers = [];
  List<dynamic> relatedList = [];

  @override
  void initState() {
    super.initState();
    loadUserId();

    //  print("Api Test:${favoriteUsers.length}");
  }

  Future<void> fetchRelatedList() async {
    final response = await http
        .get(Uri.parse('http://51.20.61.70:3000/related_list/${userId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        relatedList = data;
      });
    } else {
      throw Exception('Failed to load related list');
    }
  }

  Future<void> fetchFavorites() async {
    try {
      print("User ID for Favourites:${userId}");
      final response = await http
          .get(Uri.parse('http://51.20.61.70:3000/favorites/${userId}'));

      if (response.statusCode == 200) {
        print("Status Code Ok");
        final data = json.decode(response.body);
        setState(() {
          favoriteUsers = (data[userId] as List);
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

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    if (userId != null) {
      fetchUsers();

      fetchFavorites();
      fetchRelatedList();
    }
  }

  Future<void> fetchUsers() async {
    if (userId == null) return;

    // Fetch the user's gender
    final genderResponse =
    await http.get(Uri.parse('http://51.20.61.70:3000/alldata/$userId'));

    if (genderResponse.statusCode == 200) {
      final genderData = json.decode(genderResponse.body);
      final gender = genderData['gender'];

      // Determine the appropriate API URL based on the gender
      String apiUrl;
      if (gender == 'male') {
        apiUrl = 'http://51.20.61.70:3000/all_female_user_data/$userId';
      } else if (gender == 'female') {
        apiUrl = 'http://51.20.61.70:3000/all_male_user_data/$userId';
      } else {
        throw Exception('Unknown gender value');
      }

      // Fetch the user data from the determined API URL
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          users = (data[userId] as List).reversed.toList();
        });
      } else {
        throw Exception('Failed to load users');
      }
    } else {
      throw Exception('Failed to load user gender');
    }
  }

  Future<List> fetchAdDistributorData() async {
    final response = await http
        .get(Uri.parse('http://51.20.61.70:3000/all_distributor_ads/$userId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData is List ? jsonData : [jsonData];
    } else {
      throw Exception('Failed to load ad distributor data');
    }
  }

  Future<List> fetchAdProviderData() async {
    final response =
    await http.get(Uri.parse('http://51.20.61.70:3000/all_provider_ads/$userId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData is List ? jsonData : [jsonData];
    } else {
      throw Exception('Failed to load ad provider data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMergedAds() async {
    final distributorData = await fetchAdDistributorData();
    final providerData = await fetchAdProviderData();

    List<Map<String, dynamic>> mergedAds = [];

    final maxLength = (distributorData.length > providerData.length)
        ? distributorData.length
        : providerData.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < distributorData.length || i < providerData.length) {
        mergedAds.add({
          'distributor': i < distributorData.length ? distributorData[i] : null,
          'provider': i < providerData.length ? providerData[i] : null,
        });
      }
    }

    return mergedAds;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          "New Registration",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            GridView.builder(
              shrinkWrap: true,
              itemCount:users.length,
              itemBuilder: (context, index) {

                return UserCardWidget(
                  userId: users[index]['uid'] ?? '',
                  imageUrl: users[index]
                  ['profile_picture'] ??
                      '',
                  address:
                  users[index]['address'] ?? '',
                  subfield:
                  users[index]['profile_tag'] ?? '',
                  index: index,
                );
              },
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing:
                10.0, // Horizontal space between items
                mainAxisSpacing:
                10.0, // Vertical space between items
              ),
            )

          ],
        ),
      ),
    );
  }
}
