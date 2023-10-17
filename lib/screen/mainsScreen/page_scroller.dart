import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locataireapp/API_engine/link_property_tenant.dart/query_property_tenant_by_tenant_id.dart';

import '../../API_engine/property_engine/query_property_by_id.dart';
import '../../colors/colorsrepertory.dart';
import '../../model/property.dart';
import '../../model/property_tenant.dart';
import '../../model/tenant.dart';
import 'itemsScreens/calendar.dart';
import 'itemsScreens/history.dart';
import 'itemsScreens/paiement.dart';
import 'itemsScreens/support_client.dart';



class PageScroller extends StatefulWidget {
  const PageScroller({super.key, required this.myTenant});

  final Tenant myTenant;
  

  @override
  State<PageScroller> createState() => _PageScrollerState();
}



class _PageScrollerState extends State<PageScroller> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<String> itemNames = ["Notifications", "Calendrier de paiement", "Historique de paiement", "Support clientel", "Paiement"];
  List<String> itemsDescription = [
    "Notifications et envoie des rappels du paiement de loyer",
    "Calendrier des dates d'échéance des paiements de loyer",
    "Historique détaillé de tous les paiements de loyer passés",
    "Moyen de contacter le support client en cas de questions ou de problèmes",
    "Procédure de paiement du loyer"
  ];
  
  int _index=2 ;

  PropertyTenant? _myPropertyTenant;
  PropertyTenant? get myPropertyTenant => _myPropertyTenant;
  set  myPropertyTenant(PropertyTenant? value){
    setState(() {
      _myPropertyTenant = value;
    });
  }

  Property? _myProperty;
  Property? get myProperty => _myProperty;
  set  myProperty(Property? value){
    setState(() {
      _myProperty = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setMyPropertyTenant();
  }

  void setMyPropertyTenant() async {
    print("tenantID : ${widget.myTenant.tenantID }");
    myPropertyTenant = await queryPropertyTenantByTenantID(widget.myTenant.tenantID);
    print("myPropertyTenant : ${myPropertyTenant?.propertyID}");
    if (myPropertyTenant != null) {
      print("myPropertyTenant!.propertyID : ${myPropertyTenant!.propertyID}");
      myProperty = await queryPropertyByID(myPropertyTenant!.propertyID.toString());
      print("myProperty : $myProperty");
    }else{
      myPropertyTenant = await queryPropertyTenantByTenantID(widget.myTenant.tenantID);
    }
  }

  

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;

    return  Scaffold(
      backgroundColor: clr["white"],
      bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      backgroundColor: clr["white"]!,
      color : clr["blackBlue"]!,
      buttonBackgroundColor: clr["blue"],
      index: _index,
      height : 40.h,
      animationCurve:Curves.fastOutSlowIn,
      items: <Widget>[
      FaIcon(Icons.notification_important, color: clr["white"],),
      FaIcon(FontAwesomeIcons.solidCalendarDays, color: clr["white"],),
      FaIcon(FontAwesomeIcons.clockRotateLeft, color: clr["white"],),
      Icon(Icons.contact_support, color: clr["white"],), 
      Icon(FontAwesomeIcons.moneyBill, color: clr["white"],), 

    ],
    onTap: (index) {
      //Handle button tap
      setState(() {
        _index = index;
      });
    },
  ),
  body:  SafeArea(
    child: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Icon(Icons.more_vert_outlined),
              Text(itemNames[_index], style: TextStyle(
                fontFamily: "Pacificoo",
                fontSize: 22.sp
                ),),
              CircleAvatar(
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/avatar/7309681.jpg")),
                      borderRadius:
                          BorderRadius.all(Radius.circular(100))),
                ),
              )
            ],),
            
          ),
          Container(height: size.height*.03,),
          Padding(
            padding:const  EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox( width: size.width*.9,
                  child: Text(itemsDescription[_index], 
                style: TextStyle(fontFamily: "EBGaramond",
                fontSize: 22.sp,
                fontWeight: FontWeight.bold
                ),
                
                )),
              ],
            ),
          ), 

                  Expanded(
                    child:_index==1? const Calendar() : 
                    _index==2?  History(myTenant: widget.myTenant, myProperty: myProperty ?? Property(0, "0", "0", "0"),):
                    _index==3? SupportClient(myTenant: widget.myTenant) : _index==4?
                  Paiement(myTenant: widget.myTenant, myProperty: myProperty ?? Property(0, "0", "0", "0"),) : 
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(height: size.height*.12,width: size.width*8,
                          decoration:BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black.withOpacity(0.2)),
                          child: SingleChildScrollView(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("data"),
                          )),
                          ),
                      );
                    },
                  ),
                  
                  ),
        ],
      ),
    ),
  ),
  );
  }
}