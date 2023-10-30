import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locataireapp/API_engine/support_engine/insert_support.dart';
import 'package:locataireapp/API_engine/support_engine/query_support_by_id.dart';
import 'package:locataireapp/model/support_client.dart';
import 'package:lottie/lottie.dart';

import '../../../API_engine/support_engine/delete_support.dart';
import '../../../colors/colorsrepertory.dart';
import '../../../model/tenant.dart';
import '../../../myfunctions/current_date.dart';

class SupportClient extends StatefulWidget {
  const SupportClient({super.key, required this.myTenant});

  final Tenant myTenant;

  @override
  State<SupportClient> createState() => _SupportClientState();
}

class _SupportClientState extends State<SupportClient> {
  final TextEditingController _textController = TextEditingController();
  String get textController => _textController.text;

  int sendCtr = 0;

  List<SupportClientM> _discussionList = [];
  List<SupportClientM> get discussionList => _discussionList;
  set discussionList(List<SupportClientM> value) {
    setState(() {
      _discussionList = value;
    });
  }

  @override
  void initState() {
    super.initState();
    starNotificationSync();
  }

  void starNotificationSync() async {
    for (int i = 0; i < 2; i++) {
      await Future.delayed(const Duration(seconds: 3));
      var discussionList1 =
          await queryAllSupportClientM(widget.myTenant.tenantID.toString());
      if (discussionList1.isNotEmpty) {
        discussionList = discussionList1;
      }
      print('ok');
      if (i == 1) {
        i = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<SupportClientM>>(
              future: Future.value(discussionList),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SupportClientM>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: clr["blue"],
                    ),
                  );
                }
                return snapshot.data!.isEmpty
                    ? Center(
                        child: Lottie.asset(
                            "assets/lottie/Animation_no_result.json"),
                      )
                    : ListView(
                        children: snapshot.data!.map((discussion) {
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    print(
                                        "ok : ${discussion.supportID.toString()}");
                                    deleteSupport(
                                        discussion.supportID.toString());
                                  },
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: const Color(0xFFFE4A49),
                                  icon: FontAwesomeIcons.trashCan,
                                  label: 'Supprimer',
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: discussion.source == "1"
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: discussion.message.length > 30
                                      ? size.width * .8
                                      : size.width * .6,
                                  decoration: BoxDecoration(
                                      color: discussion.source == "1"
                                          ? Colors.white
                                          : clr['blue']!.withOpacity(1),
                                      borderRadius: BorderRadius.only(
                                          topRight: discussion.source == "1"
                                              ? const Radius.circular(10)
                                              : const Radius.circular(0),
                                          topLeft: discussion.source == "1"
                                              ? const Radius.circular(0)
                                              : const Radius.circular(10),
                                          bottomLeft: const Radius.circular(10),
                                          bottomRight:
                                              const Radius.circular(10)),
                                      border: Border.all(color: clr["blue"]!)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                "              ${discussion.dateTime}  ${discussion.hourseMin}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp,
                                                  color:
                                                      discussion.source == "1"
                                                          ? Colors.black
                                                          : Colors.white,
                                                  fontFamily: "EBGaramond",
                                                ))

                                            //date de tt le monde
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width:
                                                    discussion.message.length >
                                                            30
                                                        ? size.width * .75
                                                        : size.width * .45,
                                                child: Text(
                                                  discussion.message,
                                                  style: TextStyle(
                                                      fontFamily: "EBGaramond",
                                                      fontSize: 15.sp,
                                                      color:
                                                          discussion.source ==
                                                                  "1"
                                                              ? Colors.black
                                                              : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList());
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8, top: 12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: clr["blue"]!,
                        width: 1.5,
                        style: BorderStyle.solid),
                    color: clr["white"],
                    borderRadius: BorderRadius.circular(15)),
                height:
                    sendCtr == 1 ? size.height * .09.h : size.height * .06.h,
                width: size.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: size.width * .58.w,
                      child: TextFormField(
                        maxLines: sendCtr == 1 ? 3 : 1,
                        style: TextStyle(
                            fontFamily: "EBGaramond",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                        controller: _textController,
                        onTap: () {
                          setState(() {
                            sendCtr = 1;
                          });
                        },
                        decoration: InputDecoration.collapsed(
                          hintText: 'Ajouter votre Avis',
                          hintStyle: TextStyle(
                              fontFamily: "EBGaramond",
                              color: Colors.grey,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )),
            GestureDetector(
              onTap: () async {
                String myText = textController;
                _textController.clear();
                int? i = await registerSupport(
                    widget.myTenant.tenantID.toString(),
                    myText,
                    "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}",
                    "${formatTime(DateTime.now())[0]} : ${formatTime(DateTime.now())[1]}",
                    "0");
                print("i : $i");
              },
              child: Container(
                  margin: const EdgeInsets.only(right: 3.5),
                  height: size.height * .057.h,
                  width: size.width * .13.w,
                  decoration: BoxDecoration(
                      color: clr['blue'],
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.send,
                    size: 30,
                    color: clr["white"],
                  )),
            ),
          ],
        )
      ],
    );
  }
}
