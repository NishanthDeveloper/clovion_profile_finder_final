import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/Id123456FiftyScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Registeration/3ScreenSignin.dart';

class ViewProfile extends StatefulWidget {
  final String? uid;
  final List viewprofieData;
  ViewProfile({super.key, this.uid, required this.viewprofieData});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  bool _isLoading = false;
  TextEditingController _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _favoriteItems = []; // List to store favorite items' IDs

  @override
  void initState() {
    super.initState();
    loadUserId();
    _loadAllFavoriteItems();
    fetchProfiles();
  }
  List<Map<String, dynamic>> profiles = [];
  bool isLoading = true;



  Future<void> fetchProfiles() async {
    try {
      List<Map<String, dynamic>> fetchedProfiles = [];
      for (String uid in widget.viewprofieData) {
        final response = await http.get(Uri.parse('http://51.20.61.70:3000/alldata/$uid'));
        if (response.statusCode == 200) {
          final profile = json.decode(response.body);
          fetchedProfiles.add(profile);
        } else {
          print('Failed to load profile for UID: $uid');
        }
      }
      setState(() {
        profiles = fetchedProfiles;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching profiles: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  String? userId;

  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
  }

  void _loadAllFavoriteItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Load all favorite items stored in SharedPreferences
      _favoriteItems = prefs
          .getKeys()
          .where((key) => key.startsWith('fav_') && prefs.getBool(key) == true)
          .map((key) => key.replaceFirst('fav_', ''))
          .toList();
    });
  }

  void _saveFavouriteStatus(String requestingUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fav_$requestingUser', true);
    setState(() {
      if (!_favoriteItems.contains(requestingUser)) {
        _favoriteItems.add(requestingUser);
      }
    });
  }

  void favourites(String favId) async {
    debugPrint('fav Start + $favId');

    var requestBody = {
      'myfavorite_id': favId,
    };
    print('fav Processing');

    try {
      var responsefav = await http.post(
        Uri.parse(
            "http://51.20.61.70:3000/favorites/${ThreeSigninScreen.userUidAccess}"),
        body: requestBody,
      );

      print('fav Processing');

      debugPrint("statusCodeIs${responsefav.statusCode}");

      if (responsefav.statusCode == 200) {
        print(responsefav.body);
        _saveFavouriteStatus(favId);
        debugPrint("Fav successfully");
      } else {
        print("error");
        print(responsefav.statusCode);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Saved Preferences",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _isLoading
                ? Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
                : Expanded(
              child: GridView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return Center(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Id123456FiftyScreen(
                                            userUidMaLi: 0),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                height: 216,
                                width: 172,
                                fit: BoxFit.cover,
                                imageUrl: profile['profile_picture'],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 10,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle more options
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(4),
                                        color: Colors.black38),
                                    child: const Icon(Icons.more_vert,
                                        color: Colors.white)),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(4),
                                      color: Colors.black38),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.5),
                                    child: SvgPicture.asset(
                                        "assets/images/imageIcon.svg"),
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                               profile['uid'],
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                              Text(
                              profile['address'],
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                              Text(
                            profile['profile_tag'],
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing:
                  10.0, // Horizontal space between items
                  mainAxisSpacing: 10.0, // Vertical space between items
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
