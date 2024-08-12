import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:profile_finder/core/utils/color_constant.dart';
import 'package:profile_finder/core/utils/size_utils.dart';
import 'package:profile_finder/model_final/private_inv_models/my_ques_ans.dart';
import 'package:profile_finder/model_final/private_inv_models/pi_my_clients.dart';
import 'package:profile_finder/model_final/private_inv_models/pi_my_data.dart';
import 'package:profile_finder/presentation/1ProfileFinder/MatchingList/1screen_advertisement.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/AnswerFourtyTwoScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/PiCloseAndRateFourtyFourScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/WhereIsTheSanFourtyThreeScreen.dart';
import 'package:profile_finder/presentation/1ProfileFinder/PrivateInvestigator/not_used_WriteYourQuestionFourtyFiveScreen.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomClAll.dart';
import 'package:profile_finder/widgets/CustomWidgetsCl/CustomWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CloseDealFourtyOneScreen extends StatefulWidget {
  CloseDealFourtyOneScreen(
      {super.key, required this.private_investicator_id_close_deal});

  final String private_investicator_id_close_deal;

  @override
  State<CloseDealFourtyOneScreen> createState() =>
      _CloseDealFourtyOneScreenState();
}

class _CloseDealFourtyOneScreenState extends State<CloseDealFourtyOneScreen> {
  static List<PiMyData> userList = [];

  bool LoadingFetchData = true;
  bool LoadingCallApi = true;

  Future<void> fetchData() async {
    // late String private_investicator_id;
    //  SharedPreferences preferences = await SharedPreferences.getInstance();
    //   private_investicator_id = preferences.getString("uid2").toString();

    final response = await http.get(Uri.parse(
        "http://${ApiService.ipAddress}/pi_my_data/${widget.private_investicator_id_close_deal}"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        userList = jsonResponse.map((data) => PiMyData.fromJson(data)).toList();
      });

      debugPrint(userList[0].profilePicture);

      setState(() {
        LoadingFetchData = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  String profile_finder_id = '';

  my_investigator(
    String private_investigator_id,
  ) async {
    final statusCode;
    final statusCode1;
    final body;
    final body1;
    // await Future.delayed(Duration(seconds: 2));
    // debugPrint("My investigator start");

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      profile_finder_id = preferences.getString("uid2").toString();
    });

    final url = Uri.parse(
        "http://${ApiService.ipAddress}/my_investigator/$profile_finder_id");
    final pi_client = Uri.parse(
        "http://${ApiService.ipAddress}/pi_my_clients/$private_investigator_id");
    print("private_inv_id : $private_investigator_id");

    // var request =  http.MultipartRequest('POST', url);
    var request1 = http.MultipartRequest('POST', pi_client);
    // request.fields['pf_id'] = profile_finder_id;
    // request.fields['pi_id'] = private_investigator_id;

    request1.fields['pf_id'] = profile_finder_id;
    request1.fields['pi_id'] = private_investigator_id;
    try {
      // if (_users.myInvestigator.toString().contains(private_investigator_id))
      // {

      // }

      // else{
      var request = http.MultipartRequest('POST', url);
      request.fields['pf_id'] = profile_finder_id;
      request.fields['pi_id'] = private_investigator_id;

      final response = await request.send();
      statusCode = response.statusCode;
      body = await response.stream.bytesToString();
      print("Status Code : $statusCode");
      print("UID : $body");

      // }

      final response1 = await request1.send();
      statusCode1 = response1.statusCode;
      body1 = await response1.stream.bytesToString();

      print("Status Code1 : $statusCode1");
      print("UID1 : $body1");
      print(
          "Private Investigator selected succesfully, Uid : $private_investigator_id");

      if (response.statusCode == 200) {
        // setState(() {
        //   hire[hiree] = true;
        // });

        // Navigator.pushNamed(context, AppRoutes.paymentOfInvestigatorFourtyScreen);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CloseDealFourtyOneScreen(
              private_investicator_id_close_deal: private_investigator_id,
            );
          }),
        );
      }
    } catch (e) {
      print("Do Something When Error Occurs");
    }
  }

  late String _profile_finder_id;

  static List<MyQuesAndAns1> privateInvestigatorCollection = [];

  Future<String?> initialiseData() async {
    setState(() {
      privateInvestigatorCollection = [];
    });
  }

  callApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _profile_finder_id = preferences.getString("uid2").toString();
    final response = await http.get(Uri.parse(
        "http://${ApiService.ipAddress}/my_question_and_answer/$_profile_finder_id"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      final id = data.keys.first;
      for (final pi in data[id]) {
        privateInvestigatorCollection.add(MyQuesAndAns1.fromJson(pi));
      }

      setState(() {
        LoadingCallApi = false;
      });
    }
  }

  List<PiMyClients> piMyClients = [];
  List<PiMyClients> piMyClients1 = [];



  bool loadingFetchPiMyClients = true;

  fetchPiMyClients() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _profile_finder_id = preferences.getString("uid2").toString();
    final response = await http.get(Uri.parse(
        "http://${ApiService.ipAddress}/pi_my_clients/${widget.private_investicator_id_close_deal}"));

    debugPrint(
        "http://${ApiService.ipAddress}/pi_my_clients/${widget.private_investicator_id_close_deal}");

    debugPrint('fetchPiMyClients');

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map;
      final id = data.keys.first;
      for (final pi in data[id]) {

      
        piMyClients.add(PiMyClients.fromJson(pi));
      }

      for (var i = 0; i < piMyClients.length; i++) {
        
      if (piMyClients[i].uid == _profile_finder_id) {
        piMyClients1.add(piMyClients[i]);
        
      }
        
      }

      // if (piMyClients) {
        
      // }

     

      setState(() {
        loadingFetchPiMyClients = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    initialiseData().whenComplete(
      () => callApi(),
    );

    fetchData();

    fetchPiMyClients();

    piMyClients = [];
    
    piMyClients1 = [];
    

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Your code here will be executed when the screen is returned to
  //   // after navigating back from another screen
  //   initialiseData().whenComplete(
  //     () => callApi(),
  //   );

  //   fetchData();

  //   fetchPiMyClients();

  //   piMyClients = [];
  //    piMyClients1 = [];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClAppbarLeadGridSuffHeart(
          testingNextPage: AnswerFourtyTwoScreen()),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              // Text( piMyClients1[0].uid.toString()),
              // Text( piMyClients1.length.toString()),
              

              // Text(piMyClients.length.toString()),
              // Text(piMyClients[0].uid.toString()),
              // Text(piMyClients[1].uid.toString()),
              // Text(piMyClients[2].uid.toString()),
              // Text(piMyClients[3].uid.toString()),
              
              // Text('Title'),
              // Text(privateInvestigatorCollection.length.toString()),
              // Text(
              //   LoadingFetchData.toString(),
              //   style: TextStyle(),
              // ),
              // Text(
              //   LoadingCallApi.toString(),
              //   style: TextStyle(),
              // ),
              // Text(
              //   loadingFetchPiMyClients.toString(),
              //   style: TextStyle(),
              // ),
              (LoadingFetchData || LoadingCallApi || loadingFetchPiMyClients)
                  ? CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(privateInvestigatorCollection[0].question![0].toString()),
                        ClProfilePictureWithCover(
                          itemHeight: DeviceSize.itemHeight,
                          profilePicturepath:
                              userList[0].profilePicture.toString(),
                          coverPicturepath:
                              userList[0].profilePicture.toString(),
                          name: userList[0].firstName ?? 'Ariene McCoy',

                          place:
                              "${userList[0].officeCity}${',  '}${userList[0].officeCountry}",

                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CloseAndRateFourtyFourScreen(
                                        private_investicator_id: widget
                                            .private_investicator_id_close_deal,
                                      )),
                            );
                          },
                          hire: false, elevatedButtonText: 'Close Deal & Rate',
                          rating: userList[0].totalRatings ?? 0.0,
                          //  onTapHirePi: () {  },
                        ),

                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorConstant.clgreyborderColor)),
                          height: DeviceSize.itemHeight * 1.5,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("Overall Task Stats"),
                              // SizedBox(
                              //   height: DeviceSize.itemHeight / 10,
                              // ),
                              CircularPercentIndicator(
                                radius: 70,
                                progressColor: Colors.green,
                                lineWidth: 7,
                                percent: 70 / 100,
                                center: const Text(
                                  '70%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                footer: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 25),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorConstant
                                                  .clPurpleBorderColor,
                                              width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Notify To Complete",
                                          style: TextStyle(
                                            color: ColorConstant.clPurple6,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          controller: ScrollController(),
                          //  debugPrint(_myInvestigators.qkokamx1Qqf![0].firstName.toString());
                          // itemCount: MyQuestionAndAnswer.privateInvestigatorCollection.length,
                          itemCount: piMyClients1[0].questin!.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return WhereIsTheSanFourtyThreeScreen(
                                      private_investicator_id: widget
                                          .private_investicator_id_close_deal,
                                    );
                                  }),
                                );
                              },
                              child: CustomClCheckboxWithQuestionWidget(
                                  question:
                                      piMyClients1[0].questin![index].toString(),

                                  // 'where is the San Sebastian home? and she completed here graduation?',
                                  completed: true,
                                  answer:
                                      piMyClients1[0].answer![index].toString()),
                            );
                          }),
                        ),
                        SizedBox(
                          height: DeviceSize.itemHeight / 2,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MyElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return WriteYourQuestionFourtyFiveScreen(
                    private_investicator_id_ques:
                        widget.private_investicator_id_close_deal,
                  );
                }),
              );
            },
            borderRadius: BorderRadius.circular(10),
            backgroundColor: Colors.transparent,
            // gradient: LinearGradient(
            //     begin: Alignment(0, 0.56),
            //     end: Alignment(1, 0.56),
            //     colors: [ColorConstant.indigo500, ColorConstant.purpleA100]),
            child: const Text(
              '\u002b Add New Question',
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

// gradient: LinearGradient(begin: Alignment(0, 0.56), end: Alignment(1, 0.56), colors: [
//                                                                                 ColorConstant.indigo500,
//                                                                                 ColorConstant.purpleA100
//                                                                               ])
