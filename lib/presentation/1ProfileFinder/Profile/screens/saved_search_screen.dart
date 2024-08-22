import 'package:flutter/material.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Profile/screens/filter_screen.dart';

class SavedSearchScreen extends StatelessWidget {
  const SavedSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 237, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 237, 255, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Save Search",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "16 Saved Preference Available",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(110, 113, 122, 1)),
                    ),
                  ],
                ),
                // filter Button
                InkWell(
                  onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return FilterScreen();
                          }),
                        );
                  },
                  child: Container(
                    height: 38,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(123, 97, 255, 1), width: 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Filter",
                          style:
                              TextStyle(color: Color.fromRGBO(123, 97, 255, 1)),
                        ),
                        Image.asset("assets/images/women-fill.png")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 17,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14, top: 17),
                                child: Container(
                                  height: 100,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(123, 97, 255, 0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    "assets/images/Folder.png",
                                    height: 42,
                                    width: 42,
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dubai Profiles",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text("20 Profiles"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(123, 97, 255, 0.2),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "EdIt",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    123, 97, 255, 1)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 97,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color.fromRGBO(
                                                    123, 97, 255, 1),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "View Profiles",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      123, 97, 255, 1)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
