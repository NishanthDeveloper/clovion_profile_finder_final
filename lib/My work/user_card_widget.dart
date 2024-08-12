import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/MatchingListNavigationFourtyEightScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Registeration/3ScreenSignin.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:http/http.dart' as http;
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserCardWidget extends StatefulWidget {
  final String userId;
  final String imageUrl;
  final String address;
  final String subfield;

  UserCardWidget({
    super.key,
    required this.userId,
    required this.imageUrl,
    required this.address,
    required this.subfield,
  });

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  TextEditingController  _reasonController = TextEditingController();
  final List<String> imgList = [
    'assets/images/Rectangle 665.png',
    'assets/images/Rectangle 665.png',
    'assets/images/Rectangle 665.png',
  ];
  String? userId;
  final _formKey = GlobalKey<FormState>();
  bool _isFavourite = false;
  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });

  }
  @override
  void initState() {
    super.initState();
    _loadFavouriteStatus();
    loadUserId();
  }

  void _loadFavouriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavourite = prefs.getBool('fav_${widget.userId}') ?? false;
    });
  }

  void _saveFavouriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fav_${widget.userId}', _isFavourite);
  }

  void favourites(String favId) async {
    debugPrint(ThreeSigninScreen.userUidAccess);
    debugPrint('fav Start + $favId');

    var requestBody = {
      'myfavorite_id': favId,
    };
    print('fav Processing');

    try {
      var responsefav = await http.post(
        Uri.parse("http://51.20.61.70:3000/favorites/${ThreeSigninScreen.userUidAccess}"),
        body: requestBody,
      );

      print('fav Processing');

      debugPrint("statusCodeIs${responsefav.statusCode}");

      if (responsefav.statusCode == 200) {
        print(responsefav.body);
        setState(() {
          _isFavourite = true;
        });
        _saveFavouriteStatus();
        debugPrint("Fav successfully");
      } else {
        print("error");
        print(responsefav.statusCode);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
 showReason(BuildContext context, String requestingUserId) {


    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // title: const Text('Add'),
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _reasonController,
                        decoration: InputDecoration(
                          labelText: 'Reason',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a reason';
                          }
                          return null;
                        },
                      ),
                  SizedBox(height: 10,),
                      MyElevatedButton(
                          height: 40,
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: Colors.transparent,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              block(_reasonController.text, widget.userId, userId.toString());

                            }
                          },
                          child: const Text("Block",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),))
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }


   showAlerts(BuildContext context, String requestingUserId) {
    bool _phone = false;
    bool _whatsapp = false;
    bool _address = false;
    bool _horos = false;
    bool _socLinks = false;

    String requestedUid = '';
    String requestedPhone = '';
    String requestedWhatsapp = '';
    String requestedAddress = '';
    String requestedHoros = '';
    String requestedSocialMedia = '';

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // title: const Text('Add'),
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _phone,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _phone = newValue!;
                        });
                      },
                      title: const Text('Phone Number'),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _whatsapp,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _whatsapp = newValue!;
                        });
                      },
                      title: const Text('Whatsapp Number'),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _address,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _address = newValue!;
                        });
                      },
                      title: const Text(
                          'home or office Physical address with the house name'),
                    ),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _horos,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _horos = newValue!;
                        });
                      },
                      title: const Text('Horoscope'),
                    ),
                    CheckboxListTile(
                      // selected: ,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _socLinks,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _socLinks = newValue!;
                        });
                      },
                      title: const Text('Social Media links'),
                    ),
                    MyElevatedButton(
                        height: 40,
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          print("button call");
                          requestButtonPressed(
                            widget.userId,

                            requestedPhone = _phone ? 'on' : 'none',

                            requestedWhatsapp = _whatsapp ? 'on' : 'none',

                            requestedAddress = _address ? 'on' : 'none',

                            requestedHoros = _horos ? 'on' : 'none',

                            requestedSocialMedia = _socLinks ? 'on' : 'none',

                            // "http://${ApiService.ipAddress}/requested_list/$userUid"
                          );
                        },
                        child: const Text("Request",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),))
                  ],
                ),
              ),
            );
          });
        });
  }

   requestButtonPressed(
      String requestedUid,
      String requestedPhone,
      String requestedWhatsapp,
      String requestedAddress,
      String requestedHoros,
      String requestedSocialMedia,
      ) {
    // Define the request function
    void request() async {
      print("button calls2");

      // Retrieve the user ID from SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userUid = preferences.getString("uid2").toString();
      debugPrint(userUid);
print("User ID:${requestedUid.toString()}");
      var requestBody = {
        'received_uid': requestedUid,
        'request_phone_number': requestedPhone,
        'request_whatsapp_number': requestedWhatsapp,
        'request_address': requestedAddress,
        'request_horoscope': requestedHoros,
        'request_social_media_link': requestedSocialMedia,

      };

      print('Request Processing');

      try {
        // Make the HTTP POST request
        var response = await http.post(
          Uri.parse('http://51.20.61.70:3000/requested_list/$userUid'),
          body: requestBody,
        );

        print("statusCodeIs${response.statusCode}");

        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          print(response.body);
          print(json);
        } else {
          print("error");
          print(response.statusCode);
        }
      } catch (e) {
        print("Request failed: $e");
      }
    }

    // Call the request function to execute the HTTP request
    request();
  }


  void profMore(context, String requestingUserId, String userUid, String listType) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                child: listType == 'block'
                    ? Text("Unblock this Profile")
                    : Text("Block this Profile"),
                onPressed: () async {
                  await listType == 'block'
                      ? unBlock(requestingUserId, userUid)
                      : showReason(context,widget.userId);
                },
              ),
              TextButton(
                child: const Text("Hi"),
                onPressed: () {},
              ),
              TextButton(
                child: const Text("Request"),
                onPressed: () {
                  showAlerts(context,widget.userId);
                },
              ),
              TextButton(
                child: const Text("Share"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  final CarouselController _controller = CarouselController();
  int _current = 0;

  block(String reason, String blockedId, String userUid1) async {
    print("Block user id: $blockedId");
    debugPrint('Block Start');

    var requestBody = {
      'reason': reason,
      'blocked_id': blockedId,
    };

    var response1 = await http.post(
      Uri.parse("http://51.20.61.70:3000/block/$userUid1"),
      body: requestBody,
    );

    debugPrint("statusCodeIs${response1.statusCode}");

    if (response1.statusCode == 200) {
      print(response1.body);
      debugPrint("Blocked successfully");
      Navigator.pop(context);
      setState(() {
      });
    } else {
      print("error");
      print(response1.statusCode);
    }
  }

  static unBlock(String unBlockedId, String userUid1) async {
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
    } else {
      print("error");
      print(responseUnb.statusCode);
    }
  }

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
                onTap: () {},
                child: CachedNetworkImage(
                  height: 216,
                  width: 162,
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl,
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
                    profMore(
                        context,
                        widget.userId, // Pass widget.userId here
                        ThreeSigninScreen.userUidAccess,
                        'New Reg');
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black38),
                      child: const Icon(Icons.more_vert, color: Colors.white)),
                ),
                const SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black38),
                    child: Padding(
                      padding: const EdgeInsets.all(6.5),
                      child: SvgPicture.asset("assets/images/imageIcon.svg"),
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
                  widget.userId.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                Text(
                  widget.address,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                Text(
                  widget.subfield,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 10,
            child: InkWell(
              onTap: () {
                favourites(widget.userId);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _isFavourite ? null : Colors.grey,
                  gradient: _isFavourite
                      ? LinearGradient(
                    begin: const Alignment(-0.8, 1),
                    end: const Alignment(-0.5, -1),
                    colors: [
                      ColorConstant.indigo500,
                      ColorConstant.purpleA100,
                    ],
                  )
                      : null,
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
  }
}
