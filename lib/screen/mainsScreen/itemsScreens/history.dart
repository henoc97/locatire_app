import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locataireapp/model/property.dart';
import 'package:locataireapp/model/received.dart';
import 'package:lottie/lottie.dart';

import '../../../API_engine/received_engine/query_received.dart';
import '../../../colors/colorsrepertory.dart';
import '../../../model/tenant.dart';
import '../../funcWidgetdart/History_container.dart';

class History extends StatefulWidget {
  const History({super.key, required this.myTenant, required this.myProperty});

  final Tenant myTenant;
  final Property myProperty;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Column(
      children: [
        GestureDetector(
                    onTap: () {
                      },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h, top: 12.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: clr["blue"]!,
                              width: 1.5,
                              style: BorderStyle.solid),
                          color: clr["container"]?.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)),
                      height: size.height * .06.h,
                      width: size.width * .8.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '    Recherche',
                            style: TextStyle(fontFamily: "EBGaramond",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                                color: Colors.grey,),
                          ),
                          Container(
                              margin: const EdgeInsets.only(right: 3.5),
                              height: size.height * .05.h,
                              width: size.width * .18.w,
                              decoration: BoxDecoration(
                                  color: clr["blue"],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Icon(
                                Icons.search,
                                size: 30.sp,
                                color: clr["container"],
                              )),
                        ],
                      ),
                    ),
                  ),
        Container(height: size.height*.56,
          child: FutureBuilder<List<Received>>(
            future: queryAllReceivedpayedByTenantID(widget.myTenant.tenantID.toString(), widget.myProperty.propertyID.toString()), 
          builder: (BuildContext context, AsyncSnapshot<List<Received>> snapshot) { 
            if (!snapshot.hasData) {
                return Center(child:Center(child: Lottie.asset("assets/lottie/Animation_no_result.json"),));
              }
              return snapshot.data!.isEmpty? Center(child: Lottie.asset("assets/lottie/Animation_no_result.json"),) : 
              ListView(
                children: snapshot.data!.map((history) {
                  return HistoriesContainer(clr: clr, size: size, myTenant: widget.myTenant, myProperty: widget.myProperty, myReceived: history,);
                }).toList()
              );
          },

          )
        ),
      ],
    );
  }
}

//HistoriesContainer(clr: clr, size: size,);