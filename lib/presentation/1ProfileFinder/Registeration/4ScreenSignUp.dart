import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:http/http.dart' as http;
import 'package:profile_finder/core/services/api_services.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/1screen_advertisement.dart';
import 'package:profile_finder/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/CustomWidgetsCl/WidgetTitleAndDropdown.dart';
import '5screenOtpEntering.dart';

class FourSignUpScreen extends StatefulWidget {
  const FourSignUpScreen({super.key});

  @override
  State<FourSignUpScreen> createState() => _FourSignUpScreenState();
}

class _FourSignUpScreenState extends State<FourSignUpScreen> {
  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  String? valueChoose;
  List<String> hiringManager = [];
   String? selectedHiringManager;

  final List<String> _dropdownItemList = ["Item One", "Item Two", "Item Three"];

  final List<String> _dropdownItemListtwo = [
    "Item One",
    "Item Two",
    "Item Three"
  ];

  final int _value = 1;

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController grouptwoController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController refferalCodeController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController socialMediaController = TextEditingController();

  TextEditingController referenceController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController doorNumberController = TextEditingController();

  TextEditingController streetNameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController pincodeController = TextEditingController();










  bool _passwordVisible = true;

  bool _passwordVisible2 = true;

  var phone = '';

  var countryCode;

  var errorr;

  // CollectionReference users =
  // FirebaseFirestore.instance.collection("users");

  late int mobileNumberInt = int.parse(mobileNoController.text);

  late String userUid;
  late String userUidclean;

  int start = 30;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  // How do you know dropDown List
  String? howDoYouKnowSelectedvalue;
  List<DropdownMenuItem<String>> get howDoYouKnow {
    return [
      const DropdownMenuItem(
          value: "Social Media and Address",
          child: Text("Social Media and Address")),
      const DropdownMenuItem(value: "reference", child: Text("reference")),
      const DropdownMenuItem(value: "Myself", child: Text("Myself")),
    ];
  }

  void handlehowDoYouKnowValueChange(String? newValue) {
    setState(() {
      howDoYouKnowSelectedvalue = newValue;
    });
  }

    Future<void>hiringManagerUid() async {
    var url = "http://${ApiServices.ipAddress}/all_pm_data/";
    var response = await http.get(Uri.parse(url));
    var allData = jsonDecode(response.body);
    print(allData);
    for(var i=0; i<allData.length;i++){
      setState(() {
        hiringManager.add(allData[i]['uid']);
      });
    }

  }

  // Future register() async {
  /*
    // Api Sign Up
    var url = Uri.parse("http://192.168.1.29/API/Marriyo/Auth/signup.php");
    var response = await http.post(url, body: {
      "username": emailController.text.toString(),
      "password": passwordController.text.toString(),
      "mobileNumber": mobileNoController.text,
      "refferalCode": refferalCodeController.text,
    });


    var data = json.decode(response.body);
    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exit!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
      await FirebaseAuth.instance
        .verifyPhoneNumber(
      // phoneNumber: '+91 9894 018 373',
      phoneNumber: countryCode+mobileNoController.text,

      verificationCompleted:
          (PhoneAuthCredential
              credential) {},
      verificationFailed:
          (FirebaseAuthException e) {
        setState(() {
          errorr = e.toString();
        });
        print({
          'The provided phone number is not valid.' +
              errorr.toString()
        });
      },
      codeSent: (String verificationId,
          int? resendToken) {},
      codeAutoRetrievalTimeout:
          (String verificationId) {},
    );
      Navigator.pushNamed(context, AppRoutes.iphone1313ProSixScreen);
    }
    */

  // Firebase Sign Up
  //   _databaseManager.signUp(
  //       context,
  //       emailController.text,
  //       passwordController.text,
  //       mobileNoController.text,
  //       refferalCodeController.text);
  // }

  // String MainURL = "http://127.0.0.1:8000/";
  // var MainURL = "http://127.0.0.1:8000/signup/";

  // static const signUpurl = 'http://192.168.1.29:8000/signup/';

  // void callApi(Uri url) async {
  //   final request = http.MultipartRequest('POST', url);
  //   request.fields['email'] = emailController.text;
  //   request.fields['password'] = passwordController.text;
  //   request.fields['referral_code'] = refferalCodeController.text;
  //   request.fields['mobile'] = mobileNoController.text;
  //   final send = await request.send();
  //   final response = await http.Response.fromStream(send);
  //   print(response.statusCode);
  //   print(response.body);
  // }

  // String URL =  Uri.parse('http://10.0.2.2:3000/signup/');
  // void myFunction() async {
  //   // var data = {};
  //   var headers = {
  //     // 'Content-Type': 'application/json',
  //     'Context-Type': 'application/json',
  //   };
  //   var requestBody = {
  //     // 'email': emailController.text,
  //     // 'mobile': mobileNoController.text,
  //     // 'password': passwordController.text,
  //     // 'referral_code': refferalCodeController.text

  //     'email': 'arun2@gmail.com',
  //     'mobile': '9876543211',
  //     'password': '123456',
  //     'referral_code': '123123',
  //   };

  //   var response = await http.post(Uri.parse('http://10.0.2.2:8000/signup/'),
  //       headers: headers, body: requestBody);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     print('A network error occurred');
  //   }
  // }

  void signup() async {
    print('Sign up method');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    var headers = {
      // 'Content-Type': 'application/json',
      'Context-Type': 'application/json',
    };

    var requestBody = {
      // 'email': 'umsrn333@gmail.com',
      // 'mobile': 9876543210,
      // 'password': "12345",
      // 'password2': "12345",
      // 'code': "",

      // 'email': emailController.text,
      // 'mobile': mobileNoController.text,
      // 'password': passwordController.text,
      // 'password2': confirmPasswordController.text,
      // 'code': refferalCodeController.text

      'email': emailController.text,
      'mobile': '+$countryCode ${mobileNoController.text}',
      'password': passwordController.text,
      'referral_code': refferalCodeController.text,
      'name': firstNameController.text,
      'door_no':doorNumberController.text,
      'street_name':streetNameController.text,
      'address':addressController.text,
      'pincode':pincodeController.text,
      'my_manager': selectedHiringManager.toString(),

      // 'email': 'abc@gmail.com',
      // 'mobile': '9876543211',
      // 'password': '123456',
      // 'referral_code': '123123',
    };

    // print(mobileNoController.text.runtimeType);

    var response = await http.post(
      Uri.parse('http://${ApiService.ipAddress}/signup/'),
      // Uri.parse('http://10.0.2.2:8000/signup/'),

      headers: headers,
      // body: jsonEncode(requestBody),
      body: requestBody,
    );

    // http://10.0.2.2:8000/

    if (response.statusCode == 200) {
      setState(() {
        userUid = response.body;
        userUidclean = userUid.substring(1, userUid.length - 1);
        preferences.setString("uid2", userUidclean.toString());
        preferences.setString("userEmail", emailController.text);
      });
      // Navigator.pushNamed(context, AppRoutes.iphone1313ProSixScreen);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return FiveOtpEnteringScreen(
            emailid: emailController.text,
            timerr: 3,
            userUidafterOtp: userUidclean,
          );
        }),
      );
    } else {
      userUidclean =
          emailController.text.substring(2, emailController.text.length - 2);
    }
  }

  @override
  void initState() {
    countryCode = '+91';
    howDoYouKnowSelectedvalue = howDoYouKnow[2].value;
    hiringManagerUid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(
              child: SizedBox(
                // height: MediaQuery.of(context).size.height - kToolbarHeight,
                // width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    //  Container(child: Image.asset('assets/images/img_vector.png')),

                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/img_background_first.png'),
                            fit: BoxFit.cover),
                      ),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,

                      //Inside the Container SingleChildScrollView
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 30, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 7),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),

                              // FirstName TextField
                                const Text("First Name*"),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        
                                        controller: firstNameController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("First Name can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your First Name",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),

                              // LastName TextField
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Last Name*"),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        
                                        controller: lastNameController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("Last Name can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your Last Name ",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),

                               // DoorNumber TextField
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Door Number*"),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        
                                        controller: doorNumberController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("Door Number can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your Door Number ",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),

                              // Street Name TextField
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Street Name*"),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        
                                        controller: streetNameController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("Street Name can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your Street Name ",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),
                               // Address TextField
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Address*"),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        
                                        controller: addressController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("Address can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your Address",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),

                               // Pincode TextField
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Pincode*"),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: pincodeController,
                                        validator: (value) {
                                          
                                          if (value!.isEmpty) {
                                            return ("Pincode can't be Empty");
                                          }
                                         
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Your Pincode",
                                            hintStyle: TextStyle(fontSize: 14)),
                                      )),
                                ),
                              ),
                              // Email Field
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("Emaill ID*"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        autofillHints: const [
                                          AutofillHints.email
                                        ],
                                        controller: emailController,
                                        validator: (value) {
                                          RegExp regex = RegExp(r'^.{6,}$');
                                          if (value!.isEmpty) {
                                            return ("Email can't be Empty");
                                          }
                                          if (!regex.hasMatch(value)) {
                                            return ("Please Enter Valid Email");
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "example@demo.com"),
                                      )),
                                ),
                              ),

                              // Mobile Controller

                              // Text('$countryCode ${mobileNoController.text}'),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("Mobile*"),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: IntlPhoneField(
                                            // flagsButtonMargin: EdgeInsets.only(left: 10),
                                            disableLengthCheck: true,
                                            dropdownIconPosition:
                                                IconPosition.trailing,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            initialCountryCode: 'IN',
                                            // onCountryChanged: (phone) {
                                            //   countryCode = phone.code.toString();
                                            // },

                                            onCountryChanged: (value) {
                                              setState(() {
                                                countryCode =
                                                    value.fullCountryCode;
                                              });
                                            },
                                            // onChanged: (phone) {
                                            //   setState(() {
                                            //     countryCode = phone.countryCode;
                                            //   });
                                            // },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextFormField(
                                            autofillHints: const [
                                              AutofillHints.telephoneNumber
                                            ],
                                            controller: mobileNoController,
                                            // key: ValueKey(_initialCountryData ?? 'country'),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(8),
                                              // border: OutlineInputBorder(),
                                              border: InputBorder.none,

                                              // hintText: _initialCountryData?.phoneMaskWithoutCountryCode,
                                              hintText: "Enter Mobile No.",
                                              hintStyle: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(.3)),
                                              errorStyle: const TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            keyboardType: TextInputType.phone,
                                            // inputFormatters: [
                                            //   PhoneInputFormatter(
                                            //     allowEndlessPhone: false,
                                            //     // defaultCountryCode: _initialCountryData?.countryCode,
                                            //   )
                                            // ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),

                              // Password Field

                              // Text(countryCode),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("Password*"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: TextFormField(
                                      autofillHints: const [
                                        AutofillHints.password
                                      ],
                                      obscureText: _passwordVisible,
                                      controller: passwordController,
                                      validator: (value) {
                                        RegExp regex = RegExp(r'^.{6,}$');
                                        if (value!.isEmpty) {
                                          return ("Password is required for login");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("Please Enter Valid Password (Min. 6 Characters)");
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              icon: Icon(_passwordVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              }),
                                          suffixIconColor: Colors.black,
                                          border: InputBorder.none,
                                          hintText: "********"),
                                    ),
                                  ),
                                ),
                              ),

                              // Confirm Paasword Field
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text("Confirm Password*"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        autofillHints: const [
                                          AutofillHints.password
                                        ],
                                        obscureText: _passwordVisible2,
                                        controller: confirmPasswordController,
                                        validator: (value) {
                                          if (confirmPasswordController
                                                      .text.length >
                                                  6 &&
                                              passwordController.text !=
                                                  value) {
                                            return "Password not Match";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                                icon: Icon(_passwordVisible2
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                                onPressed: () {
                                                  setState(() {
                                                    _passwordVisible2 =
                                                        !_passwordVisible2;
                                                  });
                                                }),
                                            suffixIconColor: Colors.black,
                                            border: InputBorder.none,
                                            hintText: "********"),
                                      )),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              
                               WidgetTitleAndDropdown(
                  DdbTitle: "Hiring Manager*",
                  DdbHint: "Select",
                  DbdItems: hiringManager,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedHiringManager = newValue!;
                      print(selectedHiringManager);
                    });
                    // uploadAboutMe("Physical Status", dropdownValue.toString());
                  },
                ),

                              // referal Code Field
                              Text("Refferal Code"),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: TextFormField(
                                        controller: refferalCodeController,
                                        autofillHints: const [
                                          AutofillHints.password
                                        ],
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "6 digit"),
                                      )),
                                ),
                              ),

                              //konw about DropDown Button
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                    "How do you know about Marriyo matrimony ?"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SizedBox(
                                    height: 54,
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          hintText: 'Select',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            borderSide: BorderSide(
                                              width: 0,
                                              color: Colors.grey.shade100,
                                            ),
                                          ),
                                          fillColor: Colors.grey.shade100,
                                          filled: true),
                                      items: howDoYouKnow,
                                      value: howDoYouKnowSelectedvalue,
                                      onChanged: handlehowDoYouKnowValueChange,
                                    )),
                              ),

                              if (howDoYouKnowSelectedvalue ==
                                  'Social Media and Address') ...[
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("Social Media and Address*"),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: TextFormField(
                                            controller: socialMediaController,
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "Enter your Social Media and Address"),
                                          )),
                                    ))
                              ] else if (howDoYouKnowSelectedvalue ==
                                  'reference') ...[
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text("reference*"),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: TextFormField(
                                            controller: referenceController,
                                            autofillHints: const [
                                              AutofillHints.password
                                            ],
                                            decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter your reference"),
                                          )),
                                    ))
                              ] else if (howDoYouKnowSelectedvalue == 'Myself') ...[
                               
                              ],

                              // SignUp BUtton
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (passwordController.text.isNotEmpty &&
                                        confirmPasswordController
                                            .text.isNotEmpty) {
                                      if (passwordController.text ==
                                          confirmPasswordController.text) {
                                        signup();
                                      } else {
                                        Fluttertoast.showToast(
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          msg: 'Password Not Match',
                                          toastLength: Toast.LENGTH_SHORT,
                                        );
                                      }

                                      // await users.add({
                                      //   "name": "kumar",
                                      //   'age': 16
                                      // }).then((value) => print("User Added"));
                                    } else {
                                      // _showToast(
                                      //     context, "Password not Match");
                                      Fluttertoast.showToast(
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        msg: 'Enter Password',
                                        toastLength: Toast.LENGTH_SHORT,
                                      );
                                    }
                                    // Navigator.pushNamed(
                                    //     context, AppRoutes.FourteenScreenscr);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 25, 50, 192),
                                          Color.fromARGB(255, 25, 50, 192),
                                          // Colors.indigo,
                                          Colors.purple,
                                          Color.fromARGB(255, 219, 110, 238),
                                        ]),
                                        borderRadius: BorderRadius.circular(8)),
                                    height: 50,
                                    // width: 296,
                                    child: const Center(
                                        child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Text(
                                    "Sign Up with",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    // textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                              'assets/images/img_icons8google1.svg'),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        // 'assets/images/img_facebook_deep_purple_a200.svg'),

                                        'assets/images/img_floatingicon.svg',
                                        height: 40,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: SvgPicture.asset(
                                              'assets/images/img_applefill.svg'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Have Account Already?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        // textAlign: TextAlign.end,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.threeSigninScreen);
                                          },
                                          child: const SizedBox(
                                            // color: Colors.white,
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                "Sign In",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 69, 49, 245)),
                                                // textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
