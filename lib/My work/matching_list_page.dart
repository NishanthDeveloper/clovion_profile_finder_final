/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:profile_finder/My%20work/add_widget.dart';
import 'package:profile_finder/My%20work/user_card_widget.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/MatchingListNavigationFourtyEightScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
  List<dynamic> adData = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
    fetchAds();
    print("Add Data Length : ${adData.length}");
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse('http://51.20.61.70:3000/all_male_user_data/LBZE96YAY29'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        users = (data['LBZE96YAY29'] as List).reversed.toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> fetchAds() async {
    try {
      final providerResponse = await http.get(Uri.parse('http://51.20.61.70:3000/all_provider_ads/'));
      final distributorResponse = await http.get(Uri.parse('http://51.20.61.70:3000/add_distributor_ads/'));

      if (providerResponse.statusCode == 200 && distributorResponse.statusCode == 200) {
        final providerData = json.decode(providerResponse.body);
        final distributorData = json.decode(distributorResponse.body);

        // Debugging output
        print('Provider Data: $providerData');
        print('Distributor Data: $distributorData');

        setState(() {
          adData = [
            ...providerData['ads'] as List, // Adjust based on actual structure
            ...distributorData['ads'] as List // Adjust based on actual structure
          ];
        });
      } else {
        throw Exception('Failed to load ads: ${providerResponse.statusCode} ${distributorResponse.statusCode}');
      }
    } catch (e) {
      print('Error fetching ads: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppbarLeadGridSuffHeart(
        testingNextPage: MatchingListNavigationFourtyEightScreen(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                            decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 20, right: 10),
                                  child: SvgPicture.asset('assets/images/img_clock_black_900.svg', height: 5),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset('assets/images/img_settings.svg'),
                                ),
                                hintText: "Search",
                                hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                filled: true,
                                fillColor: ColorConstant.clTextFormfieldFilledColor,
                                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                      items: imgList.map((item) => Padding(
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
                                padding: EdgeInsets.all(DeviceSize.itemWidth / 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Every male has a female and every female has a male but The problem is dependent on choosing',
                                      style: TextStyle(color: Colors.white, fontSize: DeviceSize.itemHeight / 15),
                                    ),
                                    Text(
                                      '"Find a perfect similar taste and Get the beautiful life"',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: DeviceSize.itemHeight / 10),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Color(0xFF7B61FF)
                                  : Color(0xFF7B61FF)).withOpacity(_current == entry.key ? 0.9 : 0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    Text(
                      "New Registration",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xff2B3674)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '76 ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xFF7B61FF),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Matching profiles are available for you',
                                style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xff6E717A), fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "View all",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xff7B61FF)),
                        )
                      ],
                    ),
                    SizedBox(height: DeviceSize.itemHeight / 10),
                    users.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                      height: 250, // Set a fixed height for the ListView
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: users.length + (users.length ~/ 2), // Adjust item count to account for ads
                        itemBuilder: (context, index) {
                          if ((index + 1) % 3 == 0) {
                            int adIndex = (index ~/ 3) % adData.length;
                            return  Container();
                          }
                          int userIndex = index - (index ~/ 3); // Adjust index to get the correct user
                          return UserCardWidget(
                            userId: users[userIndex]['uid'],
                            imageUrl: users[userIndex]['id_card_1'],
                            address: users[userIndex]['address'],
                            subfield: users[userIndex]['email'],
                          );
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


 */