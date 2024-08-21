import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profile_finder/My%20work/test.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/AddRefferenceFiftyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/MatchingListNavigationFourtyEightScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';

import '../presentation/1ProfileFinder/Account Settings/widgets/notification.dart';
class AddDisplayigWidget extends StatefulWidget {
  const AddDisplayigWidget({super.key});

  @override
  State<AddDisplayigWidget> createState() => _AddDisplayigWidgetState();
}

class _AddDisplayigWidgetState extends State<AddDisplayigWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppbarLeadGridSuffHeart(testingNextPage:MatchingListNavigationFourtyEightScreen(),notificationPage: NotificationPage(),),
      body:   SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CustomClSizedBoxD10Widget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: DeviceSize.itemWidth * 1.5,
                            height: 50,
                            child:


                            TextField(
                              //controller: _searchController,
                              // onChanged: _onSearchTextChanged,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 15, bottom: 20, right: 10),
                                    child: SvgPicture.asset(
                                      'assets/images/img_clock_black_900.svg',
                                      height: 5,
                                    ),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SvgPicture.asset(
                                        'assets/images/img_settings.svg'),
                                  ),
                                  hintText: "Search",
                                  hintStyle: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15),
                                  filled: true,
                                  fillColor: ColorConstant.clTextFormfieldFilledColor,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const AddRefferenceFiftyThreeScreen();
                                }),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: ColorConstant.clElevatedButtonColor),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: DeviceSize.itemHeight / 10,
                      ),
                      Container(
                        // height: DeviceSize.itemHeight * 0.70,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                    'assets/images/Rectangle 665.png',
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstant.clElevatedButtonColor),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(DeviceSize.itemWidth / 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Every male has a female and every female has amale but The problem is dependent on choosing',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: DeviceSize.itemHeight / 15),
                                    ),
                                    Text(
                                      '"Find a perfect similar taste and Get the beautiful life"',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: DeviceSize.itemHeight / 10),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: DeviceSize.itemHeight / 10,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}

