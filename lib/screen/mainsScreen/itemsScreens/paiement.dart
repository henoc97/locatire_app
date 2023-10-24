import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../API_engine/notification_engine/insert_notification.dart';
import '../../../colors/colorsrepertory.dart';
import '../../../model/property.dart';
import '../../../model/tenant.dart';
import '../../../myfunctions/current_date.dart';
import 'payment_folder/ussd_controller.dart';


class Paiement extends StatefulWidget {
  const Paiement({super.key, required this.myTenant, required this.myProperty});

  final Tenant myTenant;
  final Property myProperty;

  @override
  State<Paiement> createState() => _PaiementState();
}

class _PaiementState extends State<Paiement> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _secretCodeController = TextEditingController();
  final TextEditingController _monthPayedCodeController = TextEditingController();
  String get secretCodeController => _secretCodeController.text;
  String get monthPayedCodeController => _monthPayedCodeController.text;

  bool isFlooz = false;
  bool isTmoney = false;
  bool isLoyer = false;
  bool isAvance = false;
  bool isAutre = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    
    return Wrap(
      children: [
        Form(
          key : _formKey,
          child: Column(
            children: [
              SizedBox(
                child: Container( 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), 
                gradient: LinearGradient(begin: Alignment.topLeft,end: Alignment.bottomRight,
                colors: [clr["container"]!,  clr["blue"]!, clr["blackBlue"]!.withOpacity(0.8),])
                ),
                child: SizedBox( width: size.width*.95,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Réseaux de transfère", style: TextStyle(fontFamily: "EBGaramond",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold
                        ),),
                        ),
                      Icon(Icons.rss_feed, size: 27.sp,),
                      ],
                    ),
                    
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(width: size.width*.55,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)
                        ), color: Colors.white),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/photo/flooz.png', scale:2,),
                              Image.asset('assets/photo/tmoney.png', scale:5,),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("${widget.myProperty.propertyCost} francs cfa", 
                          style: TextStyle(fontFamily: "EBGaramond",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                        ),),
                        ],
                      ),
                    ), 
              
                    Row(
                      children: [
                        Text('${widget.myTenant.tenantContact1} / ${widget.myTenant.tenantContact2}', 
                        style: TextStyle(fontFamily: "EBGaramond",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                        ),),
                      ],
                    )
                  ],),
                )
                ),
                    ),
              ),
            
              Container(margin: const EdgeInsets.only(top: 20),
                width: 305.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                    color: clr["container"]?.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text("  ${widget.myTenant.tenantName}  ${widget.myTenant.tenantLastName}",
                          style: TextStyle(fontFamily: "EBGaramond",
                            fontWeight: FontWeight.bold,
                              color: clr["black"]?.withOpacity(0.7), fontSize: 16.sp),)
                    ),
                  ],
                ),
              ),
            
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(margin: const EdgeInsets.only(top: 10),
                    width: 140.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                        color: clr["container"]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child:Container(
                        margin: const EdgeInsets.only(left: 8),
                        width: 130.w,
                        child: Text("${widget.myProperty.propertyAddress} ",
                            style: TextStyle(fontFamily: "EBGaramond",
                              fontWeight: FontWeight.bold,
                                color: clr["black"]?.withOpacity(0.7), fontSize: 16.sp),),
                      )
                    ),
                  ),
        
                  Container(margin: const EdgeInsets.only(top: 10),
                    width: 140.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                        color: clr["container"]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      margin: const EdgeInsets.only(top: 13, left: 13),
                      child: TextFormField(
                        style: TextStyle(fontFamily: "EBGaramond",
                        fontWeight: FontWeight.bold, fontSize: 16.sp),
                        controller: _secretCodeController,
                        decoration: InputDecoration.collapsed(
                          
                          hintText: "Votre code secret",
                          hintStyle: TextStyle(fontFamily: "EBGaramond",
                            fontWeight: FontWeight.bold,
                              color: clr["black"]?.withOpacity(0.7), fontSize: 16.sp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
        
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                          children: [
                            Checkbox(value: isLoyer, onChanged: (bool? newisLoyer){
                              setState(() {
                                isLoyer = newisLoyer ?? false;
                            isAutre = false;
                            isAvance = false;
                              });
                            },),
                            Text(" Loyer", style : TextStyle(fontFamily: "EBGaramond",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold
                                ),),
                          ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: isAvance, onChanged: (bool? newisAvance){
                          setState(() {
                            isAvance = newisAvance ?? false;
                            isAutre = false;
                            isLoyer = false;
                          });
                        },),
                        Text("  Avance", style : TextStyle(fontFamily: "EBGaramond",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                            ),),
                      ],
                ),
                Row(
                      children: [
                        Checkbox(value: isAutre, onChanged: (bool? newisAutre){
                          setState(() {
                            isAutre = newisAutre ?? false;
                            isLoyer = false;
                            isAvance = false;
                          });
                        },),
                        Text("  Autre", style : TextStyle(fontFamily: "EBGaramond",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold
                            ),),
                      ],
                ),
                ],
              ),
          
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text("Le mois à payer : ", style: TextStyle(fontFamily: "EBGaramond",
                            fontWeight: FontWeight.bold, fontSize: 16.sp),),
                      Container(margin: const EdgeInsets.only(top: 10),
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                            color: clr["container"]?.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          margin: const EdgeInsets.only(top: 13, left: 13),
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            style: TextStyle(fontFamily: "EBGaramond",
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                            controller: _monthPayedCodeController,
                            decoration: InputDecoration.collapsed(
                              
                              hintText: "mm/aaaa",
                              hintStyle: TextStyle(fontFamily: "EBGaramond",
                                fontWeight: FontWeight.bold,
                                  color: clr["black"]?.withOpacity(0.7), fontSize: 16.sp),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty || value.split('/')[0].length!=2 || 
                              value.split('/')[1].length!=4 || int.parse(value.split('/')[0]) <0 ||
                              int.parse(value.split('/')[0])>13 || int.parse(value.split('/')[1])<1999
                              ) {
                                return 'Veuillez entrer une bonne date mm/aaaa';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*Container(margin: const EdgeInsets.only(top: 10),
                    width: 125.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                        color: clr["container"]?.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      
                      child: Text( 
                        "${formatDate(DateTime.now())[0]} / ${formatDate(DateTime.now())[1]} / ${formatDate(DateTime.now())[2]}",
                          style: TextStyle(fontFamily: "EBGaramond",
                        fontWeight: FontWeight.bold,
                              color: clr["black"]?.withOpacity(0.7), fontSize: 16.sp),)
                    ),
                  ),*/
                  Column(
                    children: [
                      Row(
                      children: [
                        Checkbox(value: isFlooz, onChanged: (bool? newisFlooz){
                          setState(() {
                            isFlooz = newisFlooz ?? false;
                            isTmoney = false;
                          });
                        },),
                        Text("     FLOOZ", style : TextStyle(fontFamily: "EBGaramond",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold
                            ),),
                      ],
                ),
                Row(
                  children: [
                    Checkbox(value: isTmoney, onChanged: (bool? newwisTmoney){
                      setState(() {
                        isTmoney = newwisTmoney?? false;
                        isFlooz = false;
                      });
                    },),
                    Text("TMONEY", style : TextStyle(fontFamily: "EBGaramond",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                        ),),
                  ],
                ),
                    ],
                  ),
                
                ],
              ),
            
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate() && (isLoyer || isAvance || isAutre) && (isFlooz || isTmoney)) {
                    print("ispressed");
                    USSDController.getSimName();
                await USSDController.makeMyRequest(code: "*444#",//"*155*1*1*98148143*${widget.myProperty.propertyCost}*1*$secretCodeController#", //"*155*1*1*98148143*200*1*9704#", 
              mnc:  await USSDController.getSimMNC(isFlooz==true? "MOOV" :isTmoney==true? "TOGOCEL" : "") );
            
                await Future.delayed(const Duration(seconds: 20));
                print(monthPayedCodeController);
                int? i = await insertNotification("${widget.myTenant.tenantID}", "${widget.myProperty.propertyID}",
                "Adresse : ${widget.myProperty.propertyAddress}, Mr ou Mme ${widget.myTenant.tenantName} ${widget.myTenant.tenantLastName}, vient de faire un paiement ${isLoyer? 'de loyer' : isAvance? "d' avance" : ''} par ${isFlooz? 'Flooz':'TMoney'}",// ${widget.myTenant.tenantName}  ${widget.myTenant.tenantLastName}, locataire d'adresse ${widget.myProperty.propertyAddress}, viens d'opérer un paiement " "${isLoyer? "de loyer" : isAvance? "d' avance" : ""} par ${isFlooz? "Flooz":"TMoney"}",
                widget.myProperty.propertyCost ,isLoyer?"Loyer" : isAvance? "Avance" : "Autre", monthPayedCodeController,
                "${formatDate(DateTime.now())[0]} / ${formatDate(DateTime.now())[1]} /${formatDate(DateTime.now())[2]}");
                print("i : $i");
                  } else{
                    print("je ne fais rien ");
                  }
                  
                },
                child: Container(
                  width: 200.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: clr["blue"],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                      child: Text("Valider le Paiement",
                          style:TextStyle(fontFamily: "EBGaramond",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: clr["wWrite"])))),
              ),
            ],
          ),
        ),
      ],
    ) ;
  }}