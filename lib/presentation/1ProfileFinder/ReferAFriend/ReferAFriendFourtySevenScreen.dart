import 'package:flutter/material.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/WidgetTitleAndDropdown.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/WidgetTitleAndTextfield.dart';

import '../../../My work/wishlist.dart';
import '../Account Settings/widgets/notification.dart';

class ReferAFriendFourtySeven2Screen extends StatefulWidget {
   ReferAFriendFourtySeven2Screen({super.key});

  @override
  State<ReferAFriendFourtySeven2Screen> createState() => _ReferAFriendFourtySeven2ScreenState();
}

class _ReferAFriendFourtySeven2ScreenState extends State<ReferAFriendFourtySeven2Screen> {
    // Define the list of gender options
  final List<String> _genders = ['Male', 'Female', 'Other'];

  // Define the variable to store the selected gender
  String? _selectedGender;

   void _handleGenderChange(String? newValue) {
    setState(() {
      _selectedGender = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  ClAppbarLeadGridSuffHeart(
        notificationPage: NotificationPage(),
          testingNextPage: WishlistPage()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceSize.itemHeight / 10,
              ),
              const Text(
                'Refer a friend',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: DeviceSize.itemHeight / 5,
              ),
              WidgetTitleAndTextfield(
                  textFieldTitle: 'First Name*',
                  textFieldHint: 'Enter',
                  onChanged: (value) {}),
              WidgetTitleAndTextfield(
                  textFieldTitle: 'Email*',
                  textFieldHint: 'Enter',
                  onChanged: (value) {}),
              WidgetTitleAndTextfield(
                  textFieldTitle: 'Phone Number*',
                  textFieldHint: 'Enter',
                  onChanged: (value) {}),
               WidgetTitleAndDropdown(
                selectedValue: _selectedGender,
                DbdItems: _genders,
                DdbHint: 'Select Gender',
                DdbTitle: 'Gender*',
                onChanged: _handleGenderChange,
                
              ),
              //
              SizedBox(
                height: DeviceSize.itemHeight / 10,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MyElevatedButton(
            onPressed: () {},
            borderRadius: BorderRadius.circular(10),
            width: double.maxFinite,
            backgroundColor: Colors.transparent,
            child: const Text(
              'Submit',
            )),
      ),
    );
  }
}
