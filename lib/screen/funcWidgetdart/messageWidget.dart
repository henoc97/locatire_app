import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/colorsrepertory.dart';
import '../../myfunctions/current_date.dart';


class MessageSupport extends StatefulWidget {
  const MessageSupport({super.key, required this.text});

  final String text;

  @override
  State<MessageSupport> createState() => _MessageSupportState();
}

class _MessageSupportState extends State<MessageSupport> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      
        decoration: BoxDecoration(
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
    );
  }
}