// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RequestedListWidget extends StatefulWidget {
  const RequestedListWidget({super.key});

  @override
  State<RequestedListWidget> createState() => _RequestedListWidgetState();
}

class _RequestedListWidgetState extends State<RequestedListWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 242, 255, 1),
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(244, 242, 255, 1),
          title: const Text(
            "Requested List",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          )),
      body: Column(
        children: [
          TabBar(
            dividerColor: const Color.fromRGBO(244, 242, 255, 1),
            indicator: BoxDecoration(),
            labelColor: Color.fromRGBO(51, 51, 51, 1),
            unselectedLabelColor: Color.fromRGBO(110, 113, 122, 1),
            controller: tabController,
            tabs: const [
              Tab(
                text: "Sent",
              ),
              Tab(
                text: "Recived",
              )
            ],
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: TabBarView(
                controller: tabController,
                children: [
                  requestedListView(
                    status: 'Accepted',
                  ),
                  Text('data')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class requestedListView extends StatelessWidget {
  String status;

  requestedListView({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                // StackContainer
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: 140,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: AssetImage(
                                  "assets/images/portrait-young-handsome-man-buttoning-his-jacket 1.png",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromRGBO(255, 239, 225, 1)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward,
                            size: 16,
                            color: Color(0xffF2994A),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 140,
                  width: 144,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Charlotte',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Dubai, United Arab Emirates',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: status == "Accepted"
                                ? Color.fromRGBO(242, 153, 74, 0.2)
                                : Color.fromRGBO(123, 97, 255, 0.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 12,
                              color: status == "Accepted"
                                  ? Color.fromRGBO(242, 153, 74, 1)
                                  : Color.fromRGBO(123, 97, 255, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Column(
                  children: [
                    Container(
                        height: 120,
                        //   color: Colors.deepOrange,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/rect_green.png",
                                ),
                              )),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 0.5,
                                          ),
                                          Image.asset('assets/images/hand.png'),
                                          Text(
                                            'Accepted',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/rect_grey.png",
                                ),
                              )),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 0.5,
                                          ),
                                          Image.asset(
                                              'assets/images/cancel.png'),
                                          Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Color(0xff6E717A),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
