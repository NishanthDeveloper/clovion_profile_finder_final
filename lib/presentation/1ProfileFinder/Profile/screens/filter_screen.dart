import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController tagName = TextEditingController();
  TextEditingController age = TextEditingController();

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
                style: TextStyle(fontSize: 18,color: const Color.fromRGBO(43, 54, 116, 1)),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: tagName,
                decoration: InputDecoration(
                    hintText: "Enter Your Tag Name",
                     hintStyle: const TextStyle(
                                                color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black26
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                        color: Colors.black26
                      ),
                        borderRadius: BorderRadius.circular(10))),
              ),
               SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Country"),
                    ),
                  ),
                 Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("City"),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 20,),
              Text(
                "Age*",
               style: TextStyle(fontSize: 18,color: const Color.fromRGBO(43, 54, 116, 1)),
              ),
               SizedBox(height: 15,),
              TextFormField(
                controller: age,
                decoration: InputDecoration(
                    hintText: "Enter Your Age",
                     hintStyle: const TextStyle(
                                                color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                        color: Colors.black26
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                        color: Colors.black26
                      ),
                        borderRadius: BorderRadius.circular(10))),
              ),
               SizedBox(height: 20,),
              Text(
                "Skin*",
               style: TextStyle(fontSize: 18,color: const Color.fromRGBO(43, 54, 116, 1)),
              ),
               SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Dark"),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Medium"),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 110,
                     decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Moderate Fair"),
                    ),
                  ),
                ],
              ),
               SizedBox(height: 10,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 40,
                    width: 100,
                   decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Fair"),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black26),borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text("Very Fair"),
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: 25,),
              Text(
                "Gender*",
               style: TextStyle(fontSize: 18,color: const Color.fromRGBO(43, 54, 116, 1)),
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
                                                color:  Colors.black26
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: BorderSide(
                                                width: 0,
                                                color:  Colors.black26
                                              ),
                                            ),
                                           
                                           ),
                                        items: gender,
                                        value: genderSeletedValue,
                                        onChanged: genderselectedValueChange,
                                      )),
                                ),
                                 SizedBox(height: 25,),
              Text(
                "Denomination*",
               style: TextStyle(fontSize: 18,color: const Color.fromRGBO(43, 54, 116, 1)),
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
                                                color:  Colors.black26
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              borderSide: BorderSide(
                                                width: 0,
                                                color:  Colors.black26
                                              ),
                                            ),
                                           
                                           ),
                                        items: gender,
                                        value: genderSeletedValue,
                                        onChanged: genderselectedValueChange,
                                      )),
                                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 15),
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
                  gradient: LinearGradient(
                    
                    colors: [
                        Color.fromRGBO(43, 68, 204, 1),
                        Color.fromRGBO(228, 135, 243, 1),
                      
                  ]),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Center(child: Text("Cancel",style: TextStyle(color: Colors.white),),),
              ),
            ),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  
                  colors: [
                      Color.fromRGBO(43, 68, 204, 1),
                      Color.fromRGBO(228, 135, 243, 1),
        
                ]),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(child: Text("Save",style: TextStyle(color: Colors.white),),),
            )
          ],
        ),
      ),
    );
  }
}
