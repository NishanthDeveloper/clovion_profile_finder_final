import 'package:flutter/material.dart';

import '../../../../My work/wishlist.dart';
import '../../../../widgets/CustomWidgetsCl/CustomClAll.dart';

class PmViewanswerscreen extends StatelessWidget {
  const PmViewanswerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppbarLeadArrowBackSuffHeart(
        titleText: Text(
          "Answer",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        testingNextPage: WishlistPage(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Question",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            D10HCustomClSizedBoxWidget(),
            Text(
              "Who is her best friend?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            D10HCustomClSizedBoxWidget(),
            Text(
              "Answer",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            D10HCustomClSizedBoxWidget(),
             Container(
              width: 360,
              
               child: Text(
                "Yes sir,  she completed here graduation last year and her home is same place as her mentioned in her profile.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                           ),
             ),

          ],
        ),
      ),
    );
  }
}
