import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/colorsrepertory.dart';



class RecuWidget extends StatefulWidget {
  const RecuWidget({super.key});

  @override
  State<RecuWidget> createState() => _RecuWidgetState();
}

class _RecuWidgetState extends State<RecuWidget> {
  bool isCash = false;
  bool isMobMoney = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;

    return Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          height: size.height*.4,
                          width: size.width*.5,
                          decoration: BoxDecoration(
                            color: clr['container']?.withOpacity(0.5),
                            border: Border.all(
                              color: clr["black"]!,
                              width: 3,
                              style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Reçu de paiement"),
                                      Column(
                                        children: [
                                          RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "N° de reception:",),
                                              TextSpan(text:"__________", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                          
                                          RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Date:",),
                                              TextSpan(text:"____________________", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Reception de la part de Mr ou Mm:",),
                                              TextSpan(text:"__________________", style: TextStyle(fontWeight: FontWeight.bold,)),

                                              TextSpan(
                                                text: "la somme de",),
                                              TextSpan(text:"_____________. ", style: TextStyle(fontWeight: FontWeight.bold,)),

                                              TextSpan(
                                                text: "Pour",),
                                              TextSpan(text:"_____________________. ", style: TextStyle(fontWeight: FontWeight.bold,)),  
                                              TextSpan(
                                                text: "Du",),
                                              TextSpan(text:"____________. ", style: TextStyle(fontWeight: FontWeight.bold,))  
                                            ]
                                          ),
                                          ),
                                ),

                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(children: [
                                        RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Montant courant:",),
                                              TextSpan(text:"___________cfa", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                          RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Montant payé:",),
                                              TextSpan(text:"______________cfa", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                          RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Montant du:",),
                                              TextSpan(text:"________________cfa", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                        
                                        
                                        
                                      ],),
                                      
                                    ],
                                  ),
                                ),
                                Row(
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(value: isCash, onChanged: (bool? newisCash){
                                                setState(() {
                                                  isCash = newisCash ?? false;
                                                });
                                              }),
                                              const Text("Cash"),
                                            ],
                                          ),
                                          Checkbox(value: isMobMoney, onChanged: (bool? newisMobMoney){
                                        setState(() {
                                          isMobMoney = newisMobMoney ?? false;
                                        });
                                      }),
                                      const Text("Flooz/TMoney")
                                        ],
                                      ), 
                                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: RichText(
                                            text:TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                            children: const [
                                              TextSpan(
                                                text: "Reçu par Mr ",),
                                              TextSpan(text:"_________________", style: TextStyle(fontWeight: FontWeight.bold,)) 
                                            ]
                                          ) ),
                                          
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Transform.rotate(
                                            angle: -20 * 3.141592653589793 / 180,
                                            child: Text("PAYE", style: TextStyle(
                                              fontSize: 25.sp,
                                              fontFamily: "Rubik", color: clr["blackBlue"]),),
                                          ),
                                        )
                                      ],)
                              ],
                            ),
                        );;
  }
}