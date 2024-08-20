import 'package:flutter/material.dart';
import 'package:profile_finder/core/services/api_services.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SecurityWidget extends StatefulWidget {
  const SecurityWidget({super.key});

  @override
  State<SecurityWidget> createState() => _SecurityWidgetState();
}

class _SecurityWidgetState extends State<SecurityWidget> {
  Future<void> resetPassword(BuildContext context) async {

    print('resetPassword start');
    //print('_pmMyData[0].uid : ${_pmMyData[0].uid}');
   // print('pass_reset: $emaiId');

    // setState(() {

    final SharedPreferences preferences = await SharedPreferences.getInstance();

    String? userId;
    String? userEmail;

    userId = preferences.getString('id');
    userEmail = preferences.getString('userEmail');

    //   // emaiId = preferences.getString('emailid');

    //   userId = _pmMyData[0].uid;
    //   emaiId = _pmMyData[0].email;
    // });

    var requestBody = {'pass_reset': userEmail};

    final responsepass = await http.post(
      Uri.parse('http://${ApiServices.ipAddress}/profilefinder_password_reset/$userId'),
      body: requestBody,
    );
    print(responsepass.statusCode);
    if (responsepass.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset link sent successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reset link')),
      );
    }
    print('resetPassword end');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Security",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                height: DeviceSize.itemHeight / 1.5,
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Want To Reset Your Password?',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.gray600,
                            fontSize: DeviceSize.itemWidth / 11.688),
                      ),
                      MyElevatedButton(
                        onPressed: () {
                          resetPassword(context);
                        },
                        borderRadius: BorderRadius.circular(8),
                        backgroundColor: ColorConstant.deepPurpleA200,
                        child: Text(
                          'Send Reset Link To Email',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.whiteA700,
                              fontSize: DeviceSize.itemWidth / 11.688),
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
}
