import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../colors/colorsrepertory.dart';
import '../../funcWidgetdart/History_container.dart';

class History extends StatelessWidget {
  const History({super.key});

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
          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return  HistoriesContainer(clr: clr, size: size,);
                            },
                          ),
        ),
      ],
    );
  }
}