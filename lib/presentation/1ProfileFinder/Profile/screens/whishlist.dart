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

class WhishList extends StatefulWidget {
  final String? uid;

  WhishList({super.key, this.uid});

  @override
  State<WhishList> createState() => _WhishListState();
}

class _WhishListState extends State<WhishList> {
  bool _isLoading = false;
  TextEditingController _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _favoriteItems = []; // List to store favorite items' IDs

  @override
  void initState() {
    super.initState();
    loadUserId();
    _loadAllFavoriteItems();
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
          "WishList",
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
                      itemCount: _favoriteItems.length,
                      itemBuilder: (context, index) {
                        final itemId = _favoriteItems[index];
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
                                      imageUrl: itemId,
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
                                right: 20,
                                bottom: 10,
                                child: InkWell(
                                  onTap: () {
                                    favourites(itemId);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/images/handicon.svg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
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
