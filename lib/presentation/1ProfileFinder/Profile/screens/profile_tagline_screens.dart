// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/color_constant.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/size_utils.dart';
import '../../../../model_final/model_final.dart';
import '../../../../widgets/CustomWidgetsCl/CustomClAll.dart';
import '../../../../widgets/CustomWidgetsCl/CustomWidgets.dart';
import '../../MatchingList/1screen_advertisement.dart';

class ProfileTagLineScreen extends StatefulWidget {
  const ProfileTagLineScreen({super.key});

  @override
  State<ProfileTagLineScreen> createState() => _ProfileTagLineScreenState();
}

class _ProfileTagLineScreenState extends State<ProfileTagLineScreen> {
  String title = "Profile Tag Line";
  String Profiletageline = "Please Update";
  bool buttomClicked = false;
  bool isLoading = true;
  Users _users = Users();
  late String uidUser;


  // Update ProfileTageLine

  Future updateProfileTageLine() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    uidUser = preferences.getString("uid2").toString();

    print("uid for Update $uidUser ");

    final url =
        Uri.parse("http://${ApiService.ipAddress}/about_candidate/$uidUser");
    final request = http.MultipartRequest('POST', url);
    //  request.files
    //     .add(await http.MultipartFile.fromPath('files', "headsizeFile!.path"));
    // request.fields['about_candidate_value'] = "aboutMee";
    request.fields['profile_tag'] = Profiletageline;

    try {
      final send = await request.send();
      final response = await http.Response.fromStream(send);
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Profile Tag Line Updated Successfully...!",
          backgroundColor: ColorConstant.deepPurpleA200,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
        getDataProfileTageLine();
        print("about candidate ${_users.profileTag}");
        // Future.delayed(const Duration(seconds: 10), () {});
        // Navigator.pushNamed(context, AppRoutes.FourteenScreenscr);
      }
    } catch (e) {
      print("Error While Uploading$e");
    }
  }

// getProfileTagLine
  void getDataProfileTageLine() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    uidUser = preferences.getString("uid2").toString();
    final response = await http
        .get(Uri.parse("http://${ApiService.ipAddress}/alldata/$uidUser"));
    var json = jsonDecode(response.body);

    print("statusCodeIs ${response.statusCode}");

    if (response.statusCode == 200) {
      _users = Users.fromJson(json);
      print(response.body);
      setState(() {
        isLoading = false;
        // aboutMee = _users.aboutCandidate;
      });
    } else {
      print("error");
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    
    // getData();
    getDataProfileTageLine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        appBar: const ClAppbarLeadArrowBackSuffNo(
          title: '',
          // testingNextPage: WhereIsTheSanFourtyThreeScreen(private_investicator_id: '',)
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile Tag Line",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buttomClicked
                              ? Container(
                                  height: DeviceSize.screenHeight - 150,
                                  decoration: BoxDecoration(
                                      // color:
                                      // widget.buttonclicked
                                      //     ?
                                      //  Colors.grey.shade100,
                                      // : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TextFormField(
                                    initialValue: _users.profileTag,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        Profiletageline = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                )
                              : Text(
                                  _users.profileTag.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                          const D10HCustomClSizedBoxWidget(
                            height: 50,
                          ),
                          // widget.buttonclicked ? SizedBox() : Divider(),
                          const D10HCustomClSizedBoxWidget(
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: MyElevatedButton(
            onPressed: () async {
              setState(() {
                buttomClicked = !buttomClicked;
              });
              if (buttomClicked == false) {
                updateProfileTageLine();
              }
            },
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent,
            child: Text(
              buttomClicked ? "Update" : "Edit",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
