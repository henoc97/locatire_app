import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../myfunctions/current_date.dart';





class HistoriesContainer extends StatefulWidget {
  const HistoriesContainer({
    super.key,
    required this.clr,
    required this.size,
  });

  final Map<String, Color> clr;
  final Size size;

  @override
  State<HistoriesContainer> createState() => _HistoriesContainerState();
}

class _HistoriesContainerState extends State<HistoriesContainer> {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    setState(() {
      _isSelected = value;
    });
  }

  bool _isUnroll = false;

  bool get isUnroll => _isUnroll;

  set isUnroll(bool value) {
    setState(() {
      _isUnroll = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            isSelected = false;
            
          },
          onLongPress: () {
            _isSelected = true;
            //print('cool');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: widget.clr["blue"]!)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: widget.clr["blue"],
                              child: Icon(
                                Icons.person,
                                color: widget.clr["container"],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              width: widget.size.width * .37.w,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  "AMAVIGAN Hénoc",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "EBGaramond",
                                      color: widget.clr["blue"],
                                      fontSize: 17.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                            "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              fontFamily: "EBGaramond",
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                              child: Text(
                            "Adresse : Agbalépédo",
                            style: TextStyle(
                                fontFamily: "EBGaramond",
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold),
                          )),
                          Text("Loyer :    ",style: TextStyle(
                                fontFamily: "EBGaramond",
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold) )
                          //
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
  }
