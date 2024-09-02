import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' hide CarouselController;
import 'package:profile_finder/My%20work/add_widget.dart';
import 'package:profile_finder/My%20work/new_registration_view_all.dart';
import 'package:profile_finder/My%20work/related_list_view_all.dart';
import 'package:profile_finder/My%20work/user_card_widget.dart';
import 'package:profile_finder/My%20work/wishlist.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/widgets/search.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/MatchingListNavigationFourtyEightScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchingListPage extends StatefulWidget {
  const MatchingListPage({super.key});

  @override
  State<MatchingListPage> createState() => _MatchingListPageState();
}

class _MatchingListPageState extends State<MatchingListPage> {
  final List<String> imgList = [
    'assets/images/Rectangle 665.png',
    'assets/images/Rectangle 665.png',
    'assets/images/Rectangle 665.png',
  ];
  final CarouselController _controller = CarouselController();
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
        relatedList = data.reversed.toList();
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
          favoriteUsers = (data[userId] as List).reversed.toList();
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
      fetchAds();
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
    final response = await http
        .get(Uri.parse('http://51.20.61.70:3000/all_provider_ads/$userId'));
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

  Future<void> fetchAds() async {
    try {
      final mergedAds = await fetchMergedAds();
      setState(() {
        adData = mergedAds;
      });
      print("Ad Data Fetched: ${adData.length} items");
    } catch (e) {
      print('Failed to load ads: $e');
    }
  }

  Future<void> postAdViewCount(Map<String, dynamic> ad) async {
    if (userId == null) return;

    String apiUrl;
    String adsId;

    if (ad['distributor'] != null) {
      apiUrl = 'http://51.20.61.70:3000/disads_views_count/$userId';
      adsId = ad['distributor']['ads_id'];
    } else if (ad['provider'] != null) {
      apiUrl = 'http://51.20.61.70:3000/proads_views_count/$userId';
      adsId = ad['provider']['ads_id'];
    } else {
      return;
    }

    if (postedAdIds.contains(adsId)) {
      print('View count already posted for this ad');
      return;
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'ads_id': adsId, 'views_count': "1"}),
    );

    if (response.statusCode == 200) {
      print('View count posted successfully');
      postedAdIds.add(adsId);
    } else {
      print('Failed to post view count');
    }
  }

  void showAdPopup(Map<String, dynamic> ad) {
    postAdViewCount(ad);
    print("showAdPopup called with ad: $ad");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ad Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(ad['distributor']?['id_card'] ??
                    ad['provider']?['id_card'] ??
                    '')
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: ClAppbarLeadGridSuffHeart(
        testingNextPage: MatchingListNavigationFourtyEightScreen(),
      ),
       */
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: DeviceSize.itemWidth * 1.5,
                          height: 50,
                          child: TextField(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                            uid: userId.toString(),
                                          )));
                            },
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset(
                                      'assets/images/img_clock_black_900.svg',
                                      height: 5),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset(
                                      'assets/images/img_settings.svg'),
                                ),
                                hintText: "Search",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                filled: true,
                                fillColor:
                                    ColorConstant.clTextFormfieldFilledColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const AddRefferenceFiftyThreeScreen();
                            }));
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorConstant.clElevatedButtonColor),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: imgList
                          .map((item) => Padding(
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorConstant.clElevatedButtonColor,
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            DeviceSize.itemWidth / 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Every male has a female and every female has a male but The problem is dependent on choosing',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      DeviceSize.itemHeight /
                                                          15),
                                            ),
                                            Text(
                                              '"Find a perfect similar taste and Get the beautiful life"',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      DeviceSize.itemHeight /
                                                          10),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color(0xFF7B61FF)
                                      : Color(0xFF7B61FF))
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    Text(
                      "New Registration",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2B3674)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${users.length.toString() ?? ''}  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF7B61FF),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Matching profiles are available for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff6E717A),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewRegistrationPage()));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7B61FF)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    users.isEmpty
                        ? Center(
                            child: Text(
                            "No New Registerations For You",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ))
                        : SizedBox(
                            height: 250, // Set a fixed height for the ListView
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: users.length + adData.length,
                              itemBuilder: (context, index) {
                                if (adData.isNotEmpty && (index + 1) % 3 == 0) {
                                  final adIndex = (index ~/ 3) %
                                      adData
                                          .length; // Wrap around if more ads than slots
                                  final ad = adData[adIndex];
                                  final imageUrl = ad['distributor']
                                          ?['id_card'] ??
                                      ad['provider']?['id_card'] ??
                                      '';

                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Ad tapped at index $adIndex with data: $ad");
                                      showAdPopup(ad);
                                    },
                                    child: AddWidget(
                                      imageUrl: imageUrl,
                                      adData: ad,
                                      postedAdIds: postedAdIds,
                                    ),
                                  );
                                } else {
                                  final userIndex = index -
                                      (index ~/
                                          3); // Adjust index to get the correct user
                                  if (userIndex < 0 ||
                                      userIndex >= users.length) {
                                    return SizedBox
                                        .shrink(); // Return empty widget if index is out of bounds
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      print('User tapped at index $userIndex');
                                      // Call your function or navigate to another screen here
                                    },
                                    child: UserCardWidget(
                                      userId: users[userIndex]['uid'] ?? '',
                                      imageUrl: users[userIndex]
                                              ['profile_picture'] ??
                                          '',
                                      address:
                                          users[userIndex]['address'] ?? '',
                                      subfield:
                                          users[userIndex]['profile_tag'] ?? '',
                                      index: index,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "My Preference",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2B3674)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${relatedList.length.toString() ?? ''}  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF7B61FF),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'Preference profiles are available for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff6E717A),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RelatedListPage(
                                          title: 'My Preference',
                                        )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7B61FF)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    relatedList.isEmpty
                        ? Center(
                            child: Text(
                            "No Preference For You",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ))
                        : SizedBox(
                            height: 250, // Set a fixed height for the ListView
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: relatedList.length + adData.length,
                              itemBuilder: (context, index) {
                                if (adData.isNotEmpty && (index + 1) % 3 == 0) {
                                  final adIndex = (index ~/ 3) %
                                      adData
                                          .length; // Wrap around if more ads than slots
                                  final ad = adData[adIndex];
                                  final imageUrl = ad['distributor']
                                          ?['id_card'] ??
                                      ad['provider']?['id_card'] ??
                                      '';

                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Ad tapped at index $adIndex with data: $ad");
                                      showAdPopup(ad);
                                    },
                                    child: AddWidget(
                                      imageUrl: imageUrl,
                                      adData: ad,
                                      postedAdIds: postedAdIds,
                                    ),
                                  );
                                } else {
                                  final userIndex = index -
                                      (index ~/
                                          3); // Adjust index to get the correct user
                                  if (userIndex < 0 ||
                                      userIndex >= relatedList.length) {
                                    return SizedBox
                                        .shrink(); // Return empty widget if index is out of bounds
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      print('User tapped at index $userIndex');
                                      // Call your function or navigate to another screen here
                                    },
                                    child: UserCardWidget(
                                      userId:
                                          relatedList[userIndex]['uid'] ?? '',
                                      imageUrl: relatedList[userIndex]
                                              ['profile_picture'] ??
                                          '',
                                      address: relatedList[userIndex]
                                              ['address'] ??
                                          '',
                                      subfield: relatedList[userIndex]
                                              ['profile_tag'] ??
                                          '',
                                      index: index,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                    Text(
                      "Favourites List",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2B3674)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${favoriteUsers.length.toString() ?? ''}  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF7B61FF),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Matching profiles are available for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff6E717A),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7B61FF)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    favoriteUsers.isEmpty
                        ? Center(
                            child: Text(
                            "No Favourites Available For You",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ))
                        : SizedBox(
                            height: 250, // Set a fixed height for the ListView
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: favoriteUsers.length + adData.length,
                              itemBuilder: (context, index) {
                                if (adData.isNotEmpty && (index + 1) % 3 == 0) {
                                  final adIndex = (index ~/ 3) %
                                      adData
                                          .length; // Wrap around if more ads than slots
                                  final ad = adData[adIndex];
                                  final imageUrl = ad['distributor']
                                          ?['id_card'] ??
                                      ad['provider']?['id_card'] ??
                                      '';

                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Ad tapped at index $adIndex with data: $ad");
                                      showAdPopup(ad);
                                    },
                                    child: AddWidget(
                                      imageUrl: imageUrl,
                                      adData: ad,
                                      postedAdIds: postedAdIds,
                                    ),
                                  );
                                } else {
                                  final userIndex = index -
                                      (index ~/
                                          3); // Adjust index to get the correct user
                                  if (userIndex < 0 ||
                                      userIndex >= favoriteUsers.length) {
                                    return SizedBox
                                        .shrink(); // Return empty widget if index is out of bounds
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      print('User tapped at index $userIndex');
                                      // Call your function or navigate to another screen here
                                    },
                                    child: UserCardWidget(
                                      userId:
                                          favoriteUsers[userIndex]['uid'] ?? '',
                                      imageUrl: favoriteUsers[userIndex]
                                              ['profile_picture'] ??
                                          '',
                                      address: favoriteUsers[userIndex]
                                              ['address'] ??
                                          '',
                                      subfield: favoriteUsers[userIndex]
                                              ['profile_tag'] ??
                                          '',
                                      index: index,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Related List",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2B3674)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${relatedList.length.toString() ?? ''}  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF7B61FF),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Matching profiles are available for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff6E717A),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RelatedListPage(
                                          title: 'Related List',
                                        )));
                          },
                          child: Text(
                            "View all",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff7B61FF)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    relatedList.isEmpty
                        ? Center(
                            child: Text(
                            "No Related List For You",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ))
                        : SizedBox(
                            height: 250, // Set a fixed height for the ListView
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: relatedList.length + adData.length,
                              itemBuilder: (context, index) {
                                if (adData.isNotEmpty && (index + 1) % 3 == 0) {
                                  final adIndex = (index ~/ 3) %
                                      adData
                                          .length; // Wrap around if more ads than slots
                                  final ad = adData[adIndex];
                                  final imageUrl = ad['distributor']
                                          ?['id_card'] ??
                                      ad['provider']?['id_card'] ??
                                      '';

                                  return GestureDetector(
                                    onTap: () {
                                      print(
                                          "Ad tapped at index $adIndex with data: $ad");
                                      showAdPopup(ad);
                                    },
                                    child: AddWidget(
                                      imageUrl: imageUrl,
                                      adData: ad,
                                      postedAdIds: postedAdIds,
                                    ),
                                  );
                                } else {
                                  final userIndex = index -
                                      (index ~/
                                          3); // Adjust index to get the correct user
                                  if (userIndex < 0 ||
                                      userIndex >= relatedList.length) {
                                    return SizedBox
                                        .shrink(); // Return empty widget if index is out of bounds
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      print('User tapped at index $userIndex');
                                      // Call your function or navigate to another screen here
                                    },
                                    child: UserCardWidget(
                                      userId:
                                          relatedList[userIndex]['uid'] ?? '',
                                      imageUrl: relatedList[userIndex]
                                              ['profile_picture'] ??
                                          '',
                                      address: relatedList[userIndex]
                                              ['address'] ??
                                          '',
                                      subfield: relatedList[userIndex]
                                              ['profile_tag'] ??
                                          '',
                                      index: index,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
