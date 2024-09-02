import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:profile_finder/core/services/api_services.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/image_constant.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/1screen_advertisement.dart';
import 'package:profile_finder/routes/app_routes.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/WidgetTitleAndDropdown.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/WidgetTitleAndTextfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/UploadDocument.dart';

class TenFillTheFormScreen extends StatefulWidget {
  final String registerForWhomm;
  final Function? changePage;
  const TenFillTheFormScreen(
      {super.key, required this.registerForWhomm, this.changePage});

  @override
  State<TenFillTheFormScreen> createState() => _TenFillTheFormScreenState();
}

class _TenFillTheFormScreenState extends State<TenFillTheFormScreen> {
  void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  bool validateFields(BuildContext context) {
    if (nameOfApplController.text.isEmpty ||
        addOfApplController.text.isEmpty ||
        heightOfApplController.text.isEmpty ||
        weightOfApplController.text.isEmpty ||
        bithPlaceOfApplController.text.isEmpty ||
        gender == null ||
        marital == null ||
        physical == null ||
        religion == null ||
        age == null ||
        birth_country == null ||
        birth_city == null ||
        origin == null ||
        r_country == null ||
        r_state == null ||
        r_status == null ||
        denomination == null ||
        blood_group == null ||
        temple_name.isEmpty ||
        temple_street.isEmpty ||
        temple_post_code == null ||
        temple_country == null ||
        temple_city == null ||
        temple_phone_number.isEmpty ||
        temple_diocese == null ||
        temple_local_admin == null ||
        emergency_name.isEmpty ||
        emergency_relation.isEmpty ||
        emergency_phone_number.isEmpty ||
        emergency_email.isEmpty ||
        emergency_marital_status == null ||
        occupations == null) {
      showError(context, "Please fill all required fields.");
      return false;
    }
    return true;
  }

  PageController _pageController = PageController();
  String heading = "Fill The Form";

  String? dropdownValue;

  String? Height;

  String? countryCode;
  String? martials;
  String? physicalStatus;

  // mariyal status
  List<String> maritalSts = [];

  Future<void> fetchMaritalStsStatus() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://${ApiServices.ipAddress}/superadmin/dropdownn/marital_status'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // If the API returns an empty list or null, show "No Data"
          if (data == null || data.isEmpty) {
            maritalSts = ["No Data"];
          } else {
            maritalSts =
                List<String>.from(data.map((item) => item['marital_status']));
          }
        });
      } else {
        setState(() {
          maritalSts = ["No Data"];
        });
        throw Exception('Failed to load physical statuses');
      }
    } catch (e) {
      setState(() {
        maritalSts = ["No Data"];
      });
      print("Error: $e");
    }
  }

// Physical Status
  List<String> physicalSts = [];
  Future<void> fetchPhysicalStsStatus() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://${ApiServices.ipAddress}/superadmin/dropdownn/physical_status'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // If the API returns an empty list or null, show "No Data"
          if (data == null || data.isEmpty) {
            physicalSts = ["No Data"];
          } else {
            physicalSts =
                List<String>.from(data.map((item) => item['physical_status']));
          }
        });
      } else {
        setState(() {
          physicalSts = ["No Data"];
        });
        throw Exception('Failed to load physical statuses');
      }
    } catch (e) {
      setState(() {
        physicalSts = ["No Data"];
      });
      print("Error: $e");
    }
  }

  List<String> genderItems = [
    "Male",
    "Female",
    "Others",
  ];

  List<String> religionSts = [
    "Christian",
    "Hindu",
    "Muslim",
  ];

  List<String> birthPlaceSts = ["India", "USA", "UK", "Canada", "Sri Lanka"];

  List<String> countryChoose = ["India", "USA", "UK", "Canada", "Sri Lanka"];

  List<String> stateChoose = [
    "Tamilnadu",
    "Kerala",
    "Karnataka",
    "AndhraPradesh"
  ];

  List<String> cityChoose = ["Chennai", "Delhi", "Mumbai", "Kolkatta"];

  List<String> denominationChoose = [
    "Rupee",
    "USD",
  ];

  List<String> bloodGroupChoose = [
    "A+",
    "B+",
    "AB+",
    "O+",
    "A-",
    "B-",
    "AB-",
    "O-"
  ];

  List<String> residingCounrtyChoose = [
    "India",
    "USA",
    "UK",
    "Canada",
    "Sri Lanka"
  ];

  List<String> nameofParishChoose = [
    "CSI",
    "Catholic",
  ];

  List<String> countryCodechoose = ["+91", "+1", "+51", "+115"];

  List<String> residingStatusChoose = [
    "Permanent",
    "Temperory",
  ];

  List<String> localAdminChoose = ["A", "B", "C", "D"];

  List<String> typeOfRelation = [
    "Father",
    "Mother",
    "Brother",
    "Sister",
    "Uncle",
    "Cousin"
  ];

  List<String> occupationChoose = [
    "Doctor",
    "Engineer",
    "Government Job",
    "Teacher"
  ];

  // List<String> marital_status = ["Single", "Married", "Divorced", "Widow"];

  // List<String> marital_status = ["Single", "Married", "Divorced", "Widow"];

  // List<String> marital_status = ["Single", "Married", "Divorced", "Widow"];

  // List<String> marital_status = ["Single", "Married", "Divorced", "Widow"];

  List<String> Dbditems = ["Yes", "No", "Yess", "Noo"];

  UploadDocuments uploadDocuments = UploadDocuments();

  final postID = DateTime.now().millisecondsSinceEpoch.toString();

  File? _image;

  Uint8List? fileBytes;

  // var collection = FirebaseFirestore.instance.collection('ProfileInfo');

  PlatformFile? pickedFile;

  late FToast fToast;

  String name = 'saran';
  String address = '55 B';
  String height = '';
  String weight = '';
  String marital = '';
  String gender = '';

  String physical = '';
  String religion = '';
  String age = '';
  String birth_place = '';
  String birth_country = '';
  String birth_time = '';
  String birth_city = '';
  String origin = '';
  String r_country = '';
  String r_state = '';
  String r_status = '';
  String denomination = '';
  String blood_group = '';
  String temple_name = '';
  String temple_street = '';
  String temple_post_code = '';
  String temple_country = '';
  String temple_city = '';
  String temple_phone_number = '';
  String temple_diocese = '';
  String temple_local_admin = '';
  String emergency_name = '';
  String emergency_relation = '';
  String emergency_phone_number = '';
  String emergency_email = '';
  String emergency_marital_status = '';
  String occupations = '';

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
    fetchMaritalStsStatus();
    fetchPhysicalStsStatus();
  }

  String? filename;
  String filepath = "abc";
  File? filee;

  Future pickFileFinal() async {
    // var dio = Dio();

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path ?? " ");

      setState(() {
        filee = File(result.files.single.path.toString());
        filepath = file.path;
      });
      filename = file.path.split('/').last;

      print("selected file is ${filee!.path}");
    } else {
      print("Result is null");
    }
  }

// Controllers

  TextEditingController nameOfApplController = TextEditingController();
  TextEditingController addOfApplController = TextEditingController();
  TextEditingController weightOfApplController = TextEditingController();
  TextEditingController heightOfApplController = TextEditingController();
  TextEditingController bithPlaceOfApplController = TextEditingController();

  TextInputType keyboardType = TextInputType.number;

  late String uidUser;

  List<String> _dropdownItemList = ["Item One", "Item Two", "Item Three"];

  String? valueChoose;

  Future uploadDataFilltheform() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    uidUser = preferences.getString("uid2").toString();

    print("uid is $uidUser ");

    final url =
        Uri.parse("http://${ApiServices.ipAddress}/profileform/$uidUser");
    final request = http.MultipartRequest('POST', url);

    request.fields['name'] =
        // preferences.getString("nameOfapplicant").toString();
        nameOfApplController.text;
    request.fields['address'] =
        // preferences.getString("addressOfapplicant").toString();
        addOfApplController.text;
    request.fields['height'] =
        // height.toString();
        // "155";
        heightOfApplController.text;
    request.fields['weight'] =
        // weight.toString();
        // '55';

        weightOfApplController.text;
    request.fields['birth_place'] = bithPlaceOfApplController.text;

    request.fields['gender'] = gender;
    request.fields['marital'] = marital;
    request.fields['physical'] = physical;
    request.fields['religion'] = religion;
    request.fields['age'] = age;

    request.fields['birth_country'] = birth_country;
    request.fields['birth_city'] = birth_city;
    request.fields['birth_time'] = '23:00';
    request.fields['origin'] = origin.toString();
    request.fields['r_country'] = r_country;
    request.fields['r_state'] = r_state;
    request.fields['r_status'] = r_status.toString();
    request.fields['denomination'] = denomination.toString();
    request.fields['blood_group'] = blood_group.toString();
    // request.fields['r_status'] = 'jgh';
    request.files
        .add(await http.MultipartFile.fromPath('id_card_2', filee!.path));
    request.fields['temple_name'] = temple_name;
    request.fields['temple_street'] = temple_street;
    request.fields['temple_post_code'] = temple_post_code.toString();
    request.fields['temple_country'] = temple_country.toString();
    request.fields['temple_city'] = temple_city.toString();
    request.fields['temple_phone_number'] = "$countryCode $temple_phone_number";
    request.fields['temple_diocese'] = temple_diocese.toString();
    request.fields['temple_local_admin'] = temple_local_admin.toString();
    request.fields['emergency_name'] = emergency_name.toString();
    request.fields['emergency_relation'] = emergency_relation.toString();
    request.fields['emergency_phone_number'] =
        emergency_phone_number.toString();
    request.fields['emergency_email'] = emergency_email.toString();
    request.fields['emergency_marital_status'] =
        emergency_marital_status.toString();
    request.fields['emergency_occupations'] = occupations.toString();

    try {
      final send = await request.send();
      final response = await http.Response.fromStream(send);
      print(response.statusCode);
      print(request.fields);
      print(response.body);

      if (response.statusCode == 200) {
        print('Form Filled Succesfully');

        Navigator.pushNamed(context, AppRoutes.ElevenPrimaryDetailsScreen);
        
      }
    } catch (e) {
      print("Error While Uploading File $e");
    }
  }

  List<TextEditingController> controller =
      List.generate(74, (i) => TextEditingController());

  List<dynamic> listt = List.generate(74, (i) => dynamic);

  // request.fields['marital_status'] = marital;
  // request.fields['physical_mental_status'] = physicalAndMentalStatus;
  // request.fields['primary_email'] = email;
  // request.fields['primary_phone_number'] = phone_number;
  // request.fields['dob'] = dob;
  // request.fields['why_marry'] = preferences.getString("whyShouldMarry").toString();
  // request.fields['behind_decision'] = preferences.getString("whyShouldMarry").toString();
  // request.fields['education_school'] = school;

  saveToSharedPrefferences(String nameOfID, String valueToSave) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(nameOfID, valueToSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteA700,
      appBar: AppBar(
        backgroundColor: ColorConstant.whiteA700,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorConstant.black900,
              size: 20,
            )),
        title: Text("Fill The Form",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Name of Applicant*",
                  onChanged: (newValue) {
                    if (newValue == null || newValue.trim().isEmpty) {
                      saveToSharedPrefferences("nameOfapplicant", "No Data");
                    } else {
                      saveToSharedPrefferences("nameOfapplicant", newValue);
                    }
                  },
                  textFieldController: nameOfApplController,
                ),

                // Enter Address
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Address of Applicant*",
                  onChanged: (newValue) {
                    if (newValue == null || newValue.trim().isEmpty) {
                      saveToSharedPrefferences("addressOfapplicant", "No Data");
                    } else {
                      saveToSharedPrefferences("addressOfapplicant", newValue);
                    }
                  },
                  textFieldController: addOfApplController,
                ),

                // Enter Height
                WidgetTitleAndTextfield(
                  keybordType: keyboardType,
                  textFieldHint: 'Enter',
                  textFieldTitle: "Height*",
                  onChanged: (newValue) {
                    print(
                        "controller value is ${heightOfApplController.value.text}");

                    // Check if the input value is null or empty
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      height = valueToSave;
                    });

                    saveToSharedPrefferences("height", valueToSave);
                  },
                  textFieldController: heightOfApplController,
                ),

                // EnterWeight
                WidgetTitleAndTextfield(
                  keybordType: keyboardType,
                  textFieldHint: 'Enter',
                  textFieldTitle: "Weight in KGLB*",
                  onChanged: (newValue) {
                    // Check if the input value is null or empty
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      weight = valueToSave;
                    });

                    saveToSharedPrefferences("weight", valueToSave);
                  },
                  textFieldController: weightOfApplController,
                ),

                // Gender DropDown
                WidgetTitleAndDropdown(
                  DdbTitle: "Gender*",
                  DdbHint: "Select",
                  DbdItems: genderItems,
                  onChanged: (String? newValue) {
                    setState(() {
                      // Check if newValue is null, and set a default value "No Data" if it is
                      dropdownValue = newValue ?? "No Data";
                      gender = dropdownValue!;
                    });

                    // Save to shared preferences
                    saveToSharedPrefferences("gender", dropdownValue!);
                  },
                ),

                // DropDown Marital
                WidgetTitleAndDropdown(
                  DdbTitle: "Marital Status*",
                  DdbHint: "Select",
                  DbdItems: maritalSts,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      marital = newValue;
                    });
                  },
                ),

                // DropDown PhsiycalStatus
                WidgetTitleAndDropdown(
                  DdbTitle: "Physical Status*",
                  DdbHint: "Select",
                  DbdItems: physicalSts,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      physical = newValue;
                    });
                  },
                ),

                // DropDown Religions
                WidgetTitleAndDropdown(
                  DdbTitle: "Religion*",
                  DdbHint: "Select",
                  DbdItems: religionSts,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      religion = newValue;
                    });

                    saveToSharedPrefferences("religion", newValue);
                  },
                ),
                // Age
                WidgetTitleAndTextfield(
                  keybordType: keyboardType,
                  textFieldHint: 'Enter',
                  textFieldTitle: "Age*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      age = valueToSave;
                    });

                    saveToSharedPrefferences("age", newValue);
                  },
                ),

                // birthPlace
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Birth Place*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      birth_place = valueToSave;
                    });

                    saveToSharedPrefferences('birth_place', newValue);
                  },
                  textFieldController: bithPlaceOfApplController,
                ),

                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Birth Country*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      birth_country = valueToSave;
                    });

                    saveToSharedPrefferences('birth_country', newValue);
                  },
                
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Birth Country*",
                //   DdbHint: "Select",
                //   DbdItems: Dbditems,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       birth_country = newValue;
                //     });
                //   },
                // ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Birth City*",
                //   DdbHint: "Select",
                //   DbdItems: cityChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       birth_city = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Birth City*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      birth_city = valueToSave;
                    });

                    saveToSharedPrefferences('birth_city', newValue);
                  },
                ),

                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Birth Time*",
                  onChanged: (newValue) {
                    setState(() {
                      birth_time = newValue;
                    });
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Country of Origin*",
                //   DdbHint: "Select",
                //   DbdItems: countryChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       origin = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Country of Origin*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      origin = valueToSave;
                    });

                    saveToSharedPrefferences('origin', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Residing Country*",
                //   DdbHint: "Select",
                //   DbdItems: residingCounrtyChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       r_country = newValue;
                //     });
                //     // uploadAboutMe("Residing Country", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Residing Country*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      r_country = valueToSave;
                    });

                    saveToSharedPrefferences('r_country', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Residing State*",
                //   DdbHint: "Select",
                //   DbdItems: stateChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       r_state = newValue;
                //     });
                //     // uploadAboutMe("Residing State", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Residing State*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      r_state = valueToSave;
                    });

                    saveToSharedPrefferences('r_country', newValue);
                  },
                ),
                WidgetTitleAndDropdown(
                  DdbTitle: "Denomination*",
                  DdbHint: "Select",
                  DbdItems: denominationChoose,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      denomination = newValue;
                    });
                    // uploadAboutMe("Denomination", dropdownValue.toString());
                  },
                ),
                WidgetTitleAndDropdown(
                  DdbTitle: "Blood Group*",
                  DdbHint: "Select",
                  DbdItems: bloodGroupChoose,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      blood_group = newValue;
                    });
                    // uploadAboutMe("Blood Group", dropdownValue.toString());
                  },
                ),
                WidgetTitleAndDropdown(
                  DdbTitle: "Residing Status*",
                  DdbHint: "Select",
                  DbdItems: residingStatusChoose,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      r_status = newValue;
                    });
                    // uploadAboutMe("Residing Status", dropdownValue.toString());
                  },
                ),

                DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorConstant.gray300,
                  strokeWidth: 1,
                  dashPattern: [6, 6],
                  radius: Radius.circular(10),
                  child: Container(
                    width: double.maxFinite,

                    // height: 300,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        GestureDetector(
                          onTap: () async {
                            // await PickFile();
                            // await UploadDoc();

                            await pickFileFinal();
                            // uploadDataToAws ();
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(10)),
                            child: filepath == "abc"
                                ? Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: SvgPicture.asset(
                                      ImageConstant.imgGroup228,
                                      height: 50,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      filee!,
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text("Click Here To Upload Your ID"),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 40,
                ),
                Text(
                  "Address of Parish / Temple / Mosque",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Name of Parish / Temple / Mosque*",
                //   DdbHint: "Select",
                //   DbdItems: nameofParishChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       temple_name = newValue;
                //     });
                //     // uploadAboutMe("Name of Parish / Temple / Mosque",
                //     //     dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Name of Parish / Temple / Mosque*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_name = valueToSave;
                    });

                    saveToSharedPrefferences('temple_name', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Street*",
                //   DdbHint: "Select",
                //   DbdItems: cityChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       temple_street = newValue;
                //     });
                //     // uploadAboutMe("Street", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Street*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_street = valueToSave;
                    });

                    saveToSharedPrefferences('temple_street', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Post Code*",
                //   DdbHint: "Select",
                //   DbdItems: cityChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       temple_post_code = newValue;
                //     });
                //     // uploadAboutMe("Post Code", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  keybordType: keyboardType,
                  textFieldHint: 'Enter',
                  textFieldTitle: "Post Code*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_post_code = valueToSave;
                    });

                    saveToSharedPrefferences('temple_post_code', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Country*",
                //   DdbHint: "Select",
                //   DbdItems: countryChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       temple_country = newValue;
                //     });
                //     // uploadAboutMe("Country", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Country*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_country = valueToSave;
                    });

                    saveToSharedPrefferences('temple_country', newValue);
                  },
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "City*",
                //   DdbHint: "Select",
                //   DbdItems: cityChoose,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       temple_city = newValue;
                //     });
                //     // uploadAboutMe("City", dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "City*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_city = valueToSave;
                    });

                    saveToSharedPrefferences('temple_city', newValue);
                  },
                ),
                Text("Phone Number"),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10)
                              // labelText: "Select"
                              ),
                          // underline: SizedBox(),
                          isExpanded: true,
                          // autofocus: true,

                          dropdownColor: Colors.white,
                          // focusColor: Colors.white,
                          hint: const Text(
                            '+971',
                            style: TextStyle(fontSize: 14),
                          ),
                          // value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          // elevation: 16,

                          // onChanged: (String? newValue) {
                          //   setState(() {
                          //     dropdownValue = newValue!;
                          //   });
                          // },

                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value;
                              countryCode = value;
                            });
                          },

                          items: countryCodechoose
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 7,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            temple_phone_number = value;
                          },
                          // controller: _textFieldController,

                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            // hintText: textFieldHint,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.grey.shade100,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                // WidgetTitleAndTextfield(
                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Diocese*",
                //   onChanged: (newValue) {
                //     setState(() {
                //       // dropdownValue = newValue!;
                //       temple_diocese = newValue;
                //     });
                //     // uploadAboutMe(_detailName[1], dropdownValue.toString());
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Diocese*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      temple_diocese = valueToSave;
                    });

                    saveToSharedPrefferences('temple_diocese', newValue);
                  },
                ),
                WidgetTitleAndDropdown(
                  DdbTitle: "Local Admin*",
                  DdbHint: "Select",
                  DbdItems: localAdminChoose,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      temple_local_admin = newValue;
                    });
                    // uploadAboutMe("Local Admin", dropdownValue.toString());
                  },
                ),

                Text(
                  "Emergency Contact",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                // WidgetTitleAndDropdown(
                //   DdbTitle: "Name",
                //   DdbHint: "Select",
                //   DbdItems: Dbditems,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       dropdownValue = newValue!;
                //       emergency_name=newValue;
                //     });
                //     // uploadAboutMe("Emergency Name", dropdownValue.toString());
                //   },
                // ),

                // WidgetTitleAndTextfield(
                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Name*",
                //   onChanged: (newValue) {
                //     setState(() {
                //       // dropdownValue = newValue!;
                //       emergency_name = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Name*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      emergency_name = valueToSave;
                    });

                    saveToSharedPrefferences('emergency_name', newValue);
                  },
                ),

                WidgetTitleAndDropdown(
                  DdbTitle: "Type Of Relation",
                  DdbHint: "Select",
                  DbdItems: typeOfRelation,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      emergency_relation = newValue;
                    });
                    // uploadAboutMe(
                    //     "Emergency Type of Relation", dropdownValue.toString());
                  },
                ),

                // WidgetTitleAndTextfield(
                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Phone Number*",
                //   onChanged: (newValue) {
                //     setState(() {
                //       // dropdownValue = newValue!;
                //       emergency_phone_number = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Phone Number*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      emergency_phone_number = valueToSave;
                    });

                    saveToSharedPrefferences(
                        'emergency_phone_number', newValue);
                  },
                ),

                // WidgetTitleAndTextfield(
                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Email ID*",
                //   onChanged: (newValue) {
                //     setState(() {
                //       // dropdownValue = newValue!;
                //       emergency_email = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Email ID*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      emergency_email = valueToSave;
                    });

                    saveToSharedPrefferences('emergency_email', newValue);
                  },
                ),

                WidgetTitleAndDropdown(
                  DdbTitle: "Marital Status",
                  DdbHint: "Select",
                  DbdItems: maritalSts,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      emergency_marital_status = newValue;
                    });
                    // uploadAboutMe(
                    //     "Emergency Marital Status", dropdownValue.toString());
                  },
                ),
                //  WidgetTitleAndTextfield(

                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Marital Status*",
                //   // textFieldController: controller[2],
                //   onChanged: (newValue) {
                //     final valueToSave =
                //         (newValue == null || newValue.trim().isEmpty)
                //             ? "No Data"
                //             : newValue;

                //     setState(() {
                //       emergency_marital_status = valueToSave;
                //     });

                //     saveToSharedPrefferences('emergency_marital_status', newValue);
                //   },

                // ),

                // WidgetTitleAndTextfield(
                //   textFieldHint: 'Enter',
                //   textFieldTitle: "Occupationnn*",
                //   onChanged: (newValue) {
                //     setState(() {
                //       // dropdownValue = newValue!;
                //       occupations = newValue;
                //     });
                //   },
                // ),
                WidgetTitleAndTextfield(
                  textFieldHint: 'Enter',
                  textFieldTitle: "Occupationnn*",
                  // textFieldController: controller[2],
                  onChanged: (newValue) {
                    final valueToSave =
                        (newValue == null || newValue.trim().isEmpty)
                            ? "No Data"
                            : newValue;

                    setState(() {
                      occupations = valueToSave;
                    });

                    saveToSharedPrefferences('emergency_occupations', newValue);
                  },
                ),

                Container(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Add More",
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(400, 50),
                        elevation: 0,
                        side: const BorderSide(width: 1, color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),

                SizedBox(
                  height: 300,
                )
              ]),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.deepPurpleA200),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: ColorConstant.deepPurpleA200,
                      ))),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 6,
              child: Container(
                  // width: double.maxFinite,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Colors.deepPurple.shade600,
                        // Colors.deepPurple.shade400,
                        Colors.deepPurple.shade200,
                      ],
                    ),
                    color: Colors.deepPurple.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (validateFields(context)) {
                          print("Uploading Data to AWS");
                          uploadDataFilltheform();
                        }
                      },
                      child: Text(
                        "Go Next",
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
