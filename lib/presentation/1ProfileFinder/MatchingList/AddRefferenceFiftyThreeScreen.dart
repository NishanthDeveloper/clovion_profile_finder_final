import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:profile_finder/My%20work/user_card_widget.dart';
import 'dart:convert';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/WidgetTitleAndDropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRefferenceFiftyThreeScreen extends StatefulWidget {
  const AddRefferenceFiftyThreeScreen({super.key});

  @override
  State<AddRefferenceFiftyThreeScreen> createState() =>
      _AddRefferenceFiftyThreeScreenState();
}

class _AddRefferenceFiftyThreeScreenState
    extends State<AddRefferenceFiftyThreeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    loadUserId();
    super.initState();
  }
  String? userId;
  List<dynamic> savedSearch = [];
  Future<void> loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('uid2');
      print(prefs.getString("uid2").toString());
    });
    if (userId != null) {
   // postPreference();
    }
  }

  List<String> Dbditems = ["Yes", "No"];

  late String maritalStatusPreff = "";
  late String physicalStatusPreff = "";
  late String familyStatusPreff = "";
  late String ageGroupPreff = "";
  late String higherEducationPreff = "";

  bool? workingNowYes = false;
  bool? workingNowNo = false;

  List<String> maritalStatus = [
    "Unmarried",
    "Married",
    "Diverse",
    "Widow",
  ];

  List<String> physicalStatus = [
    "Normal",
    "Difficult",
  ];

  List<String> familyStatus = [
    "Small",
    "Big",
  ];

  // State variable to hold response data
  dynamic responseData;

  Future<void> postPreference() async {
    final url = Uri.parse('http://51.20.61.70:3000/my_preference/${userId}');
print("User id ${userId.toString()}");
    final body = {
      'marital_status': maritalStatusPreff,
      'physical_mental_status': physicalStatusPreff,
      'email': '',
      'family_status': familyStatusPreff,
      'age': ageGroupPreff,
      'height': '',
      'education': higherEducationPreff,
      'Working': workingNowYes == true ? 'yes' : 'no'
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Preference posted successfully');
        // Decode the response and handle both Map and List cases
        final decodedResponse = json.decode(response.body);
        setState(() {
          responseData = decodedResponse;
        });
      } else {
        print('Failed to post preference: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error posting preference: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: DeviceSize.itemHeight / 4,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  title: Center(
                    child: Text(
                      'Add Preference',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  horizontalTitleGap: 0,
                  minLeadingWidth: 0,
                ),
                SizedBox(
                  height: DeviceSize.itemHeight / 10,
                ),
                WidgetTitleAndDropdown(
                    DdbTitle: 'Marital Status*',
                    DdbHint: 'Select',
                    DbdItems: maritalStatus,
                    onChanged: (value) {
                      setState(() {
                        maritalStatusPreff = value;
                      });
                    }),
                WidgetTitleAndDropdown(
                    DdbTitle: 'Physical & Mental Status*',
                    DdbHint: 'Select',
                    DbdItems: physicalStatus,
                    onChanged: (value) {
                      setState(() {
                        physicalStatusPreff = value;
                      });
                    }),
                WidgetTitleAndDropdown(
                    DdbTitle: 'Family Status*',
                    DdbHint: 'Select',
                    DbdItems: familyStatus,
                    onChanged: (value) {
                      setState(() {
                        familyStatusPreff = value;
                      });
                    }),
                WidgetTitleAndDropdown(
                    DdbTitle: 'Age Group*',
                    DdbHint: 'Select',
                    DbdItems: familyStatus,
                    onChanged: (value) {
                      setState(() {
                        ageGroupPreff = value;
                      });
                    }),
                WidgetTitleAndDropdown(
                    DdbTitle: 'Higher Education*',
                    DdbHint: 'Select',
                    DbdItems: familyStatus,
                    onChanged: (value) {
                      setState(() {
                        higherEducationPreff = value;
                      });
                    }),
                Text(
                  'Working Now?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: DeviceSize.itemHeight / 13),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Yes'),
                        value: workingNowYes,
                        onChanged: (value) {
                          setState(() {
                            workingNowYes = value;
                            if (value == true) {
                              workingNowNo = false;
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('No'),
                        value: workingNowNo,
                        onChanged: (value) {
                          setState(() {
                            workingNowNo = value;
                            if (value == true) {
                              workingNowYes = false;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceSize.itemHeight / 10,
                ),
                MyElevatedButton(
                  onPressed: () {
                    postPreference();
                  },
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.transparent,
                  width: double.maxFinite,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Display the response data if available
                if (responseData != null) ...[
                  SizedBox(height: 20),
                  Text('My Preference:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  if (responseData is List) ...[
                    Container(
                      height: 300, // Set a height for the ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (responseData as List).length,
                        itemBuilder: (context, index) {
                          final item = (responseData as List)[index];
                          return UserCardWidget(
                              userId: responseData[index]["uid"],
                              imageUrl: responseData[index]['profile_picture'],
                              address: responseData[index]['address'],
                              subfield: responseData[index]['profile_tag'],
                              index: index);
                        },
                      ),
                    ),
                  ] else if (responseData is Map) ...[
                    Container(
                      height: 300, // Set a height for the ListView
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (responseData as Map).entries.length,
                        itemBuilder: (context, index) {
                          final entry =
                              (responseData as Map).entries.elementAt(index);
                          return ListTile(
                            title: Text('${entry.key}: ${entry.value}'),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ]),
        ),
      ),
    );
  }
}
