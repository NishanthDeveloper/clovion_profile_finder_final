import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_picker/country_picker.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController tagName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController cityController = TextEditingController();

   void updateSelectedComplexion() {
    // Collect the selected options into a list
    List<String> selected = selectedOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // Join the selected options with a comma
    selectedComplexion = selected.join(', ');
    print(selectedComplexion);
  }

  String? genderSeletedValue;

  List<DropdownMenuItem<String>> get gender {
    return [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
      const DropdownMenuItem(value: "Others", child: Text("Others")),
    ];
  }

  void genderselectedValueChange(String? newValue) {
    setState(() {
      genderSeletedValue = newValue;
    });
  }

  String? denominationSeletedValue;

  List<DropdownMenuItem<String>> get denomination {
    return [
      const DropdownMenuItem(value: "Hindu", child: Text("Hindu")),
      const DropdownMenuItem(value: "christian", child: Text("christian")),
      const DropdownMenuItem(value: "Muslim", child: Text("Muslim")),
    ];
  }

  void denominationselectedValueChange(String? newValue) {
    setState(() {
      denominationSeletedValue = newValue;
    });
  }

  dynamic responseData;

  String profile_finder_id = '';
  Future<void> postPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      profile_finder_id = preferences.getString("uid2").toString();
    });
    final url = Uri.parse(
        'http://51.20.61.70:3000/saved_search/${profile_finder_id.toString()}');

    final body = {
      'tag': tagName.text,
      'country': selectedCountry,
      'city': cityController.text,
      'age': age.text,
      'complexion': selectedComplexion,
      'gender': genderSeletedValue,
      'denomination': denominationSeletedValue,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('Preference posted successfully');
        // Decode the response and handle both Map and List cases
        final decodedResponse = json.decode(response.body);
        setState(() {
          responseData = decodedResponse;
        });
        Navigator.pop(context);
      } else {
        print('Failed to post preference: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error posting preference: $e');
    }
  }

  String selectedCountry = "Country 🌍";
  // This map stores the selected state of each option
  Map<String, bool> selectedOptions = {
    'Dark': false,
    'Medium': false,
    'Moderate Fair': false,
    'Fair': false,
    'Very Fair': false,
  };

  // This variable will store the final selection
  String selectedComplexion = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color.fromRGBO(239, 237, 255, 1),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tag Name*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: tagName,
                  decoration: InputDecoration(
                      hintText: "Enter Your Tag Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                print('Select country: ${country.name}');
                                setState(() {
                                  selectedCountry = country.name;
                                });
                              },
                              moveAlongWithKeyboard: false,
                              // Optional. Sets the theme for the country list picker.
                              countryListTheme: CountryListThemeData(
                                // Optional. Sets the border radius for the bottomsheet.
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                              ));
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: selectedCountry.isEmpty
                                  ? Text("Country 🌍")
                                  : Text(selectedCountry)),
                        )),
                    SizedBox(
                      height: 40,
                      width: 160,
                      child: TextFormField(
                        controller: cityController,
                        decoration: InputDecoration(
                            hintText: "Enter City 🏯",
                            hintStyle: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Age*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                      hintText: "Enter Your Age",
                      hintStyle: const TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Skin*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSelectableContainer('Dark'),
                    buildSelectableContainer('Medium'),
                    buildSelectableContainer('Moderate Fair', width: 110),

                    // Container(
                    //   height: 40,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: Colors.black26),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Center(
                    //     child: Text("Medium"),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSelectableContainer('Fair'),
                    buildSelectableContainer('Very Fair'),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Gender*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                      height: 54,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide:
                                BorderSide(width: 0, color: Colors.black26),
                          ),
                        ),
                        items: gender,
                        value: genderSeletedValue,
                        onChanged: genderselectedValueChange,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Denomination*",
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromRGBO(43, 54, 116, 1)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                      height: 54,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Select',
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide:
                                BorderSide(width: 0, color: Colors.black26),
                          ),
                        ),
                        items: denomination,
                        value: denominationSeletedValue,
                        onChanged: denominationselectedValueChange,
                      )),
                ),
              ],
            ),
          ),
        ),

        // Bottom navigation
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(43, 68, 204, 1),
                        Color.fromRGBO(228, 135, 243, 1),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  postPreference();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(43, 68, 204, 1),
                        Color.fromRGBO(228, 135, 243, 1),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

// Multiple selction CustomWidget

  Widget buildSelectableContainer(String label, {double width = 100}) {
    return InkWell(
      onTap: () {
        setState(() {
          // Toggle the selected state
          selectedOptions[label] = !selectedOptions[label]!;
          // Update the selectedComplexion variable
          updateSelectedComplexion();
        });
      },
      child: Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
          color: selectedOptions[label]! ?   Color.fromRGBO(43, 68, 204, 1) : Colors.transparent,
          border: Border.all(
            width: 1,
            color: selectedOptions[label]! ?   Color.fromRGBO(43, 68, 204, 1) : Colors.black26,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selectedOptions[label]! ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

 
}
