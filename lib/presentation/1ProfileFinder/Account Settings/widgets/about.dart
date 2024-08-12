import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key});

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
        title: Text(
          "About",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextButton(onPressed: (){
              _launchURL('https://marriyo.com/privacy_policy.html');
            }, child:Text("PrIvacy Policy",style: TextStyle(color: Color(0xff6E717A),fontWeight: FontWeight.w400,fontSize: 16),)),
            TextButton(onPressed: (){
              _launchURL('https://marriyo.com/termsand_conditions.html');
            }, child:Text("Terms of Use",style: TextStyle(color: Color(0xff6E717A),fontWeight: FontWeight.w400,fontSize: 16),))
          ],
        ),
      ),
    );
  }
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
