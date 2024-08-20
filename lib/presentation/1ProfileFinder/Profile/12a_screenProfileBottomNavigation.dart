import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profile_finder/My%20work/matching_list_page.dart';
import 'package:profile_finder/My%20work/test.dart';
import 'package:profile_finder/My%20work/wishlist.dart';
import 'package:profile_finder/core/utils/image_constant.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/Aed3100FourtySevenScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/widgets/notification.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/widgets/requested_list_widget.dart';
import 'package:profile_finder/presentation/1ProfileFinder/HappyCouplesUI/AddThirtyFourScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/HappyCouplesUI/HappyCouplesPackagesThirtySixScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/HighlightProfile/HighlightProfileFourtySixScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/every_male_fourty_nine_screen/EveryMaleFourtyNineScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/1_AllInvestigatorThirtyEightScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/TestAllInvestigator.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile%20Manager/AllProfileManagerScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile/12screenProfile_complete.dart';
import 'package:profile_finder/presentation/1ProfileFinder/chat/chat_Home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/color_constant.dart';
import '../../../model_final/model_final.dart';
import '../../../widgets/CustomWidgetsCl/CustomWidgets.dart';
import '../HappyCouplesUI/imagesHappyCouples.dart';
import 'package:http/http.dart' as http;

import '../MatchingList/1screen_advertisement.dart';
import '../MatchingList/every_male_fourty_nine_screen/profiles_loading_screen.dart';
import '../ReferAFriend/ReferAFriendFourtySevenScreen.dart';
import 'screens/profile_tagline_screens.dart';
import 'screens/whishlist.dart';

class ProfileBottomNavigationScreen extends StatefulWidget {
  const ProfileBottomNavigationScreen({super.key});

  @override
  State<ProfileBottomNavigationScreen> createState() =>
      _ProfileBottomNavigationScreenState();
}

class _ProfileBottomNavigationScreenState
    extends State<ProfileBottomNavigationScreen> {
  static final List<Widget> _pagesProfile = [
    const FourteenProfileCompleteness(),
    MatchingListPage(),
    //EveryMaleFourtyNineScreen(),
    // MatchingListNavigationFourtyEightScreen(),

    ProfilesLoading(),
    ChatHomeScreen(),
    // const ImagesHappyCouples(),
    // const ChatFiftyThreeScreen(),
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Users _users = Users();
  bool isLoading = true;

// List of dropdown items
  final List<String> dropdownItems = [
    'Addon',
    'Happy Couples',
    'Refer a Friend',
    'Profile Tagline',
    'Highlight Profile',
    'Profile Visibility',
    'Profile Manager',
    'Private Investigator',
    'Complaints'
  ];

  // Set initial value to "Addon"
  String? selectedValue = 'Addon';

  // Navigation Map
  final Map<String, Widget> _navigationMap = {
    //  'Addon': const Text("Addon Screen"),  // Replace with actual screens
    'Happy Couples': ImagesHappyCouples(),
    'Refer a Friend': ReferAFriendFourtySeven2Screen(),
    'Profile Tagline': ProfileTagLineScreen(),
    'Highlight Profile': HighlightProfileFourtySixScreen(),
    'Profile Visibility': ReferAFriendFourtySeven2Screen(),
    'Profile Manager': AllProfileManagerScreen(),
    'Private Investigator': AllInvestigatorThirtyEightScreen(),
    'Complaints': HighlightProfileFourtySixScreen(),
  };

  late String userUid;
  late String nameOfBrideGroom;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userUid = preferences.getString("uid2").toString();
    setState(() {
      nameOfBrideGroom = preferences.getString("nameOfBrideGroom").toString();
    });
    final response = await http
        .get(Uri.parse("http://${ApiService.ipAddress}/alldata/$userUid"));
    var json = jsonDecode(response.body);

    print("statusCodeIs${response.statusCode}");

    if (response.statusCode == 200) {
      _users = Users.fromJson(json);
      print(response.body);
      setState(() {
        isLoading = false;
      });
    } else {
      print("error");
      print(response.statusCode);
    }

    // _users= Users.fromJson(json);
    // setState(() {
    //   isLoading= false;
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getData();
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: (() {
              Scaffold.of(context).openDrawer();
            }),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
              child: SvgPicture.asset(
                'assets/images/img_grid.svg',
              ),
            ),
          ),
        ),
        actions: [
          _selectedIndex == 2
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  child: MyElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const HappyCouplesPackagesThirtySixScreen();
                      }));
                    },
                    backgroundColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    // gradient: LinearGradient(colors: [
                    //   ColorConstant.purpleA100,
                    //   ColorConstant.darkIndigogradientCl
                    // ]),
                    //  LinearGradient(colors: [ColorConstant.clLightBlue, Colors.pink, Colors.white]),
                    // height: 20,
                    width: 80,
                    child: const Text('+Add'),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return  WhishList();
                    }));
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WishlistPage()));
                          },
                          child: SvgPicture.asset(
                              'assets/images/img_heartline.svg')),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationPage()));
                          },
                          child: SvgPicture.asset(
                              'assets/images/img_notification.svg')),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ))
        ],
      ),
      drawer: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(1, -1),
            end: const Alignment(-1, 1),
            colors: [
              ColorConstant.lightIndigoGradientCl,
              ColorConstant.darkIndigogradientCl,
            ],
            // transform: GradientRotation(0.15),
          ),
        ),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 57,
                      backgroundImage:
                          NetworkImage(_users.profilePicture.toString()),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 24,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffF4F2FF),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  _users.uid.toString() == "null"
                                      ? "ID"
                                      : _users.uid.toString(),
                                  style: const TextStyle(
                                      color: Color(0xff6E717A),
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                            height: 5,
                          ),
                          Text(
                            _users.name.toString() == "null"
                                ? "Name"
                                : _users.name.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                          const SizedBox(
                            width: 5,
                            height: 5,
                          ),
                          Text(
                            _users.email.toString() == "null"
                                ? "Email"
                                : _users.email.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // UserAccountsDrawerHeader(
                //    decoration: BoxDecoration(color: Colors.transparent),

                //     accountName: Text(_users.uid.toString()),
                //    accountEmail: Text(_users.email.toString()),
                //    currentAccountPicture: CircleAvatar(
                //     backgroundImage:
                //    NetworkImage(_users.profilePicture.toString()),
                //   ),
                //   ),
                // DrawerHeader(
                //   decoration:  BoxDecoration(
                //     color: Colors.red,
                //     image: DecorationImage(image:

                //          NetworkImage(_users.profilePicture.toString())

                //           ),
                //   ), //BoxDecoration
                //   child: Row(
                //     children: [
                //       ClipOval(
                //           child: Container(
                //         height: 100,
                //         decoration:  BoxDecoration(
                //           image: DecorationImage(image:

                //          NetworkImage(_users.profilePicture.toString())

                //           ),

                //             shape: BoxShape.circle, color: Colors.pink,

                //             ),
                //       )

                //           // Image.network(
                //           //   _users.profilePicture.toString(),
                //           //   width: 70,
                //           //   height: 70,
                //           //   fit: BoxFit.cover,
                //           // ),
                //           ),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             height: 25,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(5),
                //               color: Colors.white,
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(5.0),
                //               child: Center(
                //                 child: Text(
                //                   _users.uid.toString() == "null"
                //                       ? "ID"
                //                       : _users.uid.toString(),
                //                   style: const TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 8,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Text(
                //             _users.name.toString() == "null"
                //                 ? "Name"
                //                 : _users.name.toString(),
                //             style: const TextStyle(
                //                 color: Colors.white, fontSize: 10),
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Text(
                //             _users.email.toString() == "null"
                //                 ? "Email"
                //                 : _users.email.toString(),
                //             style: const TextStyle(
                //                 color: Colors.white, fontSize: 10),
                //           )
                //         ],
                //       )
                //     ],
                //   ),
                // ),

                // Column(children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RequestedListWidget();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Requested Lists",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    /*
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ImagesHappyCouples();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Happy Couples",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const ReferAFriendFourtySeven2Screen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Refer a Friend",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Profile Tagline",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return HighlightProfileFourtySixScreen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Highlight Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Profile Visibility",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return
                                // AllInvestigatorThirtyEightScreen();

                                AllProfileManagerScreen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Profile Manager",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return
                                // AllInvestigatorThirtyEightScreen();

                                AllInvestigatorThirtyEightScreen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Private Investigator",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                   */

                    /*
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return AllProfileManagerScreen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Complaints",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    */
                    SizedBox(
                      width: 260,
                      child: DropdownButton<String>(
                        value: selectedValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                        ),
                        elevation: 16,
                        dropdownColor: Colors.black54,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 0,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            if (_navigationMap.containsKey(newValue)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      _navigationMap[newValue]!,
                                ),
                              );
                            }
                          });
                        },
                        items: dropdownItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Aed3100FourtySevenScreen();
                          }),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Account Settings",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset("assets/images/fb.svg"),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset("assets/images/youtube.svg"),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset("assets/images/twitter.svg"),
                            const SizedBox(
                              width: 20,
                            ),
                            SvgPicture.asset("assets/images/Vector (4).svg"),
                          ],
                        )),
                  ],
                ),

                // ],)
              ],
            ),
            //DrawerHeader
          ),
        ),
      ),
      body: Center(
        child: _pagesProfile.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            // icon: Icon(Icons.call),
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageConstant.imgUserBlack900),
            label: 'Matching List',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageConstant.imgRefresh),
            label: 'Happy Couples',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageConstant.imgClockBlack900),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
