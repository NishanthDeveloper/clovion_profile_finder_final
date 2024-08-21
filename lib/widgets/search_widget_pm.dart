import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/model_final/model_final.dart';
import 'package:profile_finder/model_final/profile_manager/my_manager_model.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/1screen_advertisement.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile%20Manager/AllProfileManagerScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile%20Manager/HireManagerScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile%20Manager/PmCloseDealScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PMAllUserSearch extends StatefulWidget {
  @override
  _PMAllUserSearchState createState() => _PMAllUserSearchState();
}

class _PMAllUserSearchState extends State<PMAllUserSearch> {
  List<PfMyManagerListModel> myManagerList = [];
  final double itemHeight = (size.height - kToolbarHeight - 24) / 4;

  final double itemWidth = size.width / 2;
  _navigateToNextScreen() {
    print('private_investigator_id_my_inv : $private_investigator_id_my_inv');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HireManagerScreen(
        profile_manager_id: private_investigator_id_my_inv,
      );
    }));
  }
  List<bool> hire = [];

  List<String> pi_my_Clients = [];

  // late String private_investicator_id;
  String profile_finder_id = '';

  String private_investigator_id_my_inv = '';
  List<Map<String, dynamic>>? _allUsers;
  static bool displayInvestigator = true;
  late String userUid;
  List<Map<String, dynamic>>? _filteredUsers;
  bool _loading = false;
  Future<String?> _fetchMyManagerList() async {
    setState(() {
      myManagerList = [];
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userUid = preferences.getString("uid2").toString();

    print("myManagerList function start");
    print(userUid);
    final response = await http
        .get(Uri.parse("http://${ApiService.ipAddress}/my_manager/$userUid"));
    print(response.body);
    final _data = jsonDecode(response.body) as Map;
    final idd = _data.keys.first;
    for (final pm in _data[idd]) {
      myManagerList.add(PfMyManagerListModel.fromJson(pm));
    }

  //  print('myManagerList ${findLengthOfExceptMyInvestlength}');
    print("_fetchMyManagerList function complete");
  }
  // Function to fetch all users from the API
  Future<void> fetchAllUsers() async {
    final response = await http.get(
      Uri.parse('http://51.20.61.70:3000/all_pm_data/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _allUsers = List<Map<String, dynamic>>.from(json.decode(response.body));
        _filteredUsers = _allUsers;
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Function to filter users by first_name locally
  void _filterUsersByName(String first_name) {
    setState(() {
      _filteredUsers = _allUsers?.where((user) {
        final userName = user['first_name']?.toLowerCase() ?? '';
        return userName.contains(first_name.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {

    super.initState();
    _loading = true;
    fetchAllUsers().then((_) {
      setState(() {
        _loading = false;  // Stop loading once data is fetched
      });
    }).catchError((e) {
      setState(() {
        _loading = false;
      });
      print('Error: $e');
    });
    _fetchAllPmData();

  }
  List<AllPmDataModel> _AllpmData = [];

  //
  Future<String?> _fetchAllPmData() async {
    print("_fetchAllPmData function start");
    final response = await http
        .get(Uri.parse("http://${ApiService.ipAddress}/all_pm_data/"));

    if (response.statusCode == 200) {
      final jsonoutput = jsonDecode(response.body);
      print(_AllpmData);
      _AllpmData = [
        for (final data in jsonoutput) AllPmDataModel.fromJson(data)
      ];
      print(_AllpmData);
      setState(() {
        isLoading1 = false;
      });
    }

    print("_AllpmData 0 length ${_AllpmData.length}");
  }

  bool isLoading1 = true;

  Users _users = Users();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Managers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [

          D10HCustomClSizedBoxWidget(),

          Padding(
            padding: const EdgeInsets.all(12),
            child:   TextField(
              onChanged: _filterUsersByName,
              decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      'assets/images/img_clock_black_900.svg',
                    ),
                  ),
                 /*
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child:
                    SvgPicture.asset('assets/images/img_settings.svg'),
                  ),
                  */
                  hintText: "Search",
                  filled: true,
                  fillColor: ColorConstant.clTextFormfieldFilledColor,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          if (_loading) CircularProgressIndicator(),
          if (_filteredUsers != null)
            Expanded(
              child:  ListView.builder(
                  controller: ScrollController(),
                  //  debugPrint(_myInvestigators.qkokamx1Qqf![0].firstName.toString());
                  itemCount:_filteredUsers!.length,
                  // ? findLengthOfExceptMyInvestlength

                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final user = _filteredUsers![index];
                    return GestureDetector(
                      onTap: () {

                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Column(
                              children: [


                                // allIvestigatorExceptMyList.contains(_AllpiDataTest[index].uid) ?

                                ClProfilePictureWithCover(
                                  itemHeight: itemHeight,
                                  profilePicturepath: _AllpmData[index]
                                      .profilePicture
                                      .toString(),
                                  coverPicturepath: _AllpmData[index]
                                      .profilePicture
                                      .toString(),
                                  name: _AllpmData[index]
                                      .firstName
                                      .toString(),
                                  place:
                                  _AllpmData[index].uid.toString(),

                                  onPressed: () {
                                    setState(() {
                                      private_investigator_id_my_inv =
                                          _AllpmData[index]
                                              .uid
                                              .toString();
                                    });
                                    print(
                                        'pri_inv_id : $private_investigator_id_my_inv');

                                    _navigateToNextScreen();

                                  },

                                  hire: _AllpmData[index]
                                      .email
                                      .toString()
                                      .contains(profile_finder_id),
                                  elevatedButtonText:
                                  'View Manager Details',


                                )

                                // : Container()

                              ],
                            )),
                      ),
                    );
                  })),
            ),
        ],
      ),
    );
  }
}
