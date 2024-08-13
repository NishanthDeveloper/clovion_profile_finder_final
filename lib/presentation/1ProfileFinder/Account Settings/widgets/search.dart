import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  final String uid;

  SearchScreen({super.key, required this.uid});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List _searchResults = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(_searchController.text);
    });
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) return; // Avoid unnecessary API calls for empty query

    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
          'http://51.20.61.70:3000/search_matching_list/${widget.uid}/$query'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: DeviceSize.itemWidth * 1.5,
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          'assets/images/img_clock_black_900.svg',
                          height: 5,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          'assets/images/img_settings.svg',
                        ),
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                      filled: true,
                      fillColor: ColorConstant.clTextFormfieldFilledColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
                      color: ColorConstant.clElevatedButtonColor,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                  )
                : Expanded(
                    child: _searchResults.isNotEmpty
                        ? GridView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final item = _searchResults[index];
                              return Center(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Id123456FiftyScreen(userUidMaLi:widget.index)));
                                          },
                                          child: CachedNetworkImage(
                                            height: 216,
                                            width: 172,
                                            fit: BoxFit.cover,
                                            imageUrl: item['profile_picture']
                                                .toString(),
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
                                            onTap: () {},
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Colors.black38),
                                                child: const Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.black38),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.5),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['uid'].toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            item['address'].toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            item['email'].toString(),
                                            //need to replace it as tagline
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      bottom: 10,
                                      child: InkWell(
                                        onTap: () {
                                          //favourites(widget.userId);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                              mainAxisSpacing:
                                  10.0, // Vertical space between items
                            ),
                          )
                        : Center(
                            child: Text('No results found'),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
