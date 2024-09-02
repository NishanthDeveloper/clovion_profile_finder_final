import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:profile_finder/My%20work/add_displayig_widget.dart';
import 'package:profile_finder/My%20work/test.dart';
import 'package:profile_finder/My%20work/user_card_widget.dart';
import 'package:profile_finder/routes/app_routes.dart';
import 'presentation/1ProfileFinder/MatchingList/MatchingListNavigationFourtyEightScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Check login status
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

ThemeData _baseTheme = ThemeData(
  fontFamily: "Roboto",
  canvasColor: Colors.white,
);

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _baseTheme,
      title: 'marriyoo',
      debugShowCheckedModeBanner: false,

      initialRoute: isLoggedIn ? AppRoutes. FourteenScreenBottomNavigationscr : AppRoutes.oneSplashScreen,
      routes: AppRoutes.routes,
    );
  }
}



/*
  
  // List<MyInvestigator> myInvestigator = [];

  // Future<String?> fetchMyInvestigatorData() async {
  //   setState(() {
  //     myInvestigator = [];
  //   });
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   userUid = preferences.getString("uid2").toString();

  //   print("myManagerList function start");
  //   print(userUid);
  //   final response = await http
  //       .get(Uri.parse("http://${ApiService.ipAddress}/my_investigator/$userUid"));
  //   print(response.body);
  //   final _data = jsonDecode(response.body) as Map;
  //   final idd = _data.keys.first;
  //   for (final pm in _data[idd]) {
  //     myInvestigator.add(MyInvestigator.fromJson(pm));
  //   }
  // }


// 
   body: 

      _isLoading ? 

        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Center(
                  child: Text(
                    'View Complaintsssss',
                    style: TextStyle(
                      // fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
            Expanded(child: SpinKitWave(color: Colors.blue, itemCount: 15, )),
          ],
        )

        :
        
      
      SingleChildScrollView(


  // 


  */