// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/widgets/received_list.dart';
import 'package:profile_finder/presentation/1ProfileFinder/Account%20Settings/widgets/requested_list_view.dart';

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
                text: "Rceived",
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
                  ReceivedListWidget(
                    status: 'Request',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
