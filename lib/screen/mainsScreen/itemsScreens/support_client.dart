import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locataireapp/API_engine/support_engine/insert_support.dart';
import 'package:locataireapp/API_engine/support_engine/query_support_by_id.dart';
import 'package:locataireapp/model/support_client.dart';
import 'package:locataireapp/screen/funcWidgetdart/messageWidget.dart';
import 'package:lottie/lottie.dart';

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
      discussionList = await queryAllSupportClientM(widget.myTenant.tenantID.toString());
      print('ok');
      if (i == 1) {
        i = 0;
      }
    }
  }

  List<MessageSupport> avisList = [for(int i = 0 ; i<5; i++) const MessageSupport(text: 'Problème de plomberie',)];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Column(
      children: [
        Expanded(
          
          child: FutureBuilder<List<SupportClientM>>(
            future: Future.value(discussionList), 
            builder: (BuildContext context, AsyncSnapshot<List<SupportClientM>> snapshot){
              if (!snapshot.hasData) {
                return Center(child:  CircularProgressIndicator(color: clr["blue"],),);
              }
              return snapshot.data!.isEmpty? Center(child: Lottie.asset("assets/lottie/Animation_no_result.json"),) : 
              ListView(
                children: snapshot.data!.map((discussion)  {
                return  GestureDetector(
                  onLongPress: () {
                    
                  },
                  child: Row(mainAxisAlignment: discussion.source=="1"?MainAxisAlignment.start : MainAxisAlignment.end,
                            children: [
                              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: discussion.message.length>30 ? size.width*.8: size.width*.6,
                    decoration: BoxDecoration(color: discussion.source=="1"? Colors.white : clr['blue']!.withOpacity(1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: clr["blue"]!)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                                          
                          
                            Text("              ${discussion.dateTime}  ${discussion.hourseMin}",
                              //"${formatTime(DateTime.now())[0]} : ${formatTime(DateTime.now())[1]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: discussion.source == "1"? Colors.black : Colors.white,
                                fontFamily: "EBGaramond",
                              ))
                                          
                            //date de tt le monde 
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox( width:discussion.message.length>30 ? size.width*.75: size.width*.45, 
                              child: Text(discussion.message, style: TextStyle(fontFamily: "EBGaramond",
                                fontSize: 15.sp,color: discussion.source == "1"? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold
                                ),)),
                          ],
                        ),
                            
                      ],),
                    ),
                  ),
                              ),
                            ],
                          ),
                );
                }).toList()
              );
            }),
        ),
        /*Expanded(
          child: Row(//mainAxisAlignment: index%2==0?MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width*.8,
                  decoration: BoxDecoration(color: 2%2==0? Colors.white : clr['blue']!.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: clr["blue"]!)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                                        Row(
                                          children: [
                                            CircleAvatar(backgroundColor: clr["blue"],
                                          child:Icon(Icons.person, color: clr["container"],),
                                        ),
                                            Container(margin: const EdgeInsets.only(left: 10, right: 10),width: size.width*.37.w,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text("AMAVIGAN Hénoc", style: TextStyle(fontWeight:FontWeight.bold,
                              fontFamily: "EBGaramond", 
                              color: clr["blue"], fontSize: 17.sp),),
                            ),
                          ),
                        ]),
                          Text(
                            "${formatTime(DateTime.now())[0]} : ${formatTime(DateTime.now())[1]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              fontFamily: "EBGaramond",
                            ))
                                        
                          //date de tt le monde 
                        ],
                      ),
                      SingleChildScrollView(child: Text("Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie Problème de plomberie ", style: TextStyle(fontFamily: "EBGaramond",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold
                          ),)),
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                            Text(
                            "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              fontFamily: "EBGaramond",
                            ))
                          ]),
                    ],),
                  ),
                ),
              ),
            ],
          ).toList()
        ),*/

      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(margin: const EdgeInsets.only(bottom: 8, top: 12),
                    decoration: BoxDecoration(border: Border.all(color: clr["blue"]!, width: 1.5, style: BorderStyle.solid), 
                    color:clr["white"], borderRadius: BorderRadius.circular(15)),
                          height: sendCtr==1? size.height*.09.h : size.height*.06.h,width: size.width*.8,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                width: size.width*.58.w,
                                child: TextFormField(
                                  
                                  maxLines: sendCtr==1? 3 : 1,
                                  style: TextStyle(fontFamily: "EBGaramond",fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  controller: _textController,
                                  onTap: () {
                                    
                                    setState(() {
                                      sendCtr = 1;
                                    });
                                  },
                                  decoration: InputDecoration.collapsed(hintText: 'Ajouter votre Avis',
                                  hintStyle: TextStyle(fontFamily: "EBGaramond", color: Colors.grey, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            
          ],
    )),
    GestureDetector(
                          onTap: () async {
                          
                            int? i = await registerSupport(widget.myTenant.tenantID.toString(), textController, 
                            "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}", 
                            "${formatTime(DateTime.now())[0]} : ${formatTime(DateTime.now())[1]}", "0");
                            print("i : $i");

                            _textController.clear();
                              
                              },
                          child: Container(margin: const EdgeInsets.only(right: 3.5),
                            height: size.height*.057.h,
                            width: size.width*.13.w,
                            decoration: BoxDecoration(color:clr['blue'], borderRadius: BorderRadius.circular(15)),
                            child: Icon(Icons.send, size: 30, color:clr["white"],)
                          ),
                        ),
        ],
      )
      ],
    );}
}