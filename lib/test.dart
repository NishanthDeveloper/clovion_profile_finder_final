import 'package:flutter/material.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Registeration/3ScreenSignin.dart';
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ThreeSigninScreen()));
            },
            child: Text("Test Page",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black),)),
      ),
    );
  }
}
