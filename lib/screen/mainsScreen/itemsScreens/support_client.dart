import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locataireapp/screen/funcWidgetdart/messageWidget.dart';

import '../../../colors/colorsrepertory.dart';
import '../../../myfunctions/current_date.dart';


class SupportClient extends StatefulWidget {
  const SupportClient({super.key});

  @override
  State<SupportClient> createState() => _SupportClientState();
}

class _SupportClientState extends State<SupportClient> {
  TextEditingController textController = TextEditingController();
  int sendCtr = 0;
  List<MessageSupport> avisList = [for(int i = 0 ; i<5; i++) const MessageSupport(text: 'Problème de plomberie',)];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Row(mainAxisAlignment: index%2==0?MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width*.8,
                  decoration: BoxDecoration(color: index%2==0? Colors.white : clr['blue']!.withOpacity(0.3),
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
          );
        }),
        ),

      Container(margin: const EdgeInsets.only(bottom: 8, top: 12),
                decoration: BoxDecoration(border: Border.all(color: clr["blue"]!, width: 1.5, style: BorderStyle.solid), 
                color:clr["white"], borderRadius: BorderRadius.circular(15)),
                      height: size.height*.06.h,width: size.width*.9,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            width: size.width*.57.w,
                            child: TextFormField(
                              controller: textController,
                              onTap: () {
                                setState(() {
                                  sendCtr = 1;
                                });
                              },
                              decoration: InputDecoration.collapsed(hintText: 'Ajouter votre Avis',
                              hintStyle: TextStyle(fontFamily: "EBGaramond", color: Colors.grey, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                          
                            
                              setState(() {
                                avisList.add(MessageSupport(text: textController.text));
                              });
                              print(avisList.length);
                              print(textController.text);
                              textController.clear();
                                                          
                              },
                          child: Container(margin: const EdgeInsets.only(right: 3.5),
                            height: size.height*.05.h,
                            width: size.width*.13.w,
                            decoration: BoxDecoration(color:clr['blue'], borderRadius: BorderRadius.circular(15)),
                            child: Icon(Icons.send, size: 30, color:clr["white"],)
                          ),
                        ),
      ],
    ))
      ],
    );}
}