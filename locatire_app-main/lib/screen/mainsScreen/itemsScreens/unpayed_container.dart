import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnpayedContainer extends StatefulWidget {
  const UnpayedContainer(
      {super.key,
      required this.clr,
      required this.size,
      required this.unpayedList
      //required this.myReceived,

      });

  final Map<String, Color> clr;
  final Size size;
  final List<String> unpayedList;
  //final Received? myReceived;

  @override
  State<UnpayedContainer> createState() => _UnpayedContainerState();
}

class _UnpayedContainerState extends State<UnpayedContainer> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: widget.size.height * .6,
        child: ListView.builder(
          itemCount: widget.unpayedList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Le loyer du mois de ${widget.unpayedList.reversed.toList()[index].split('-')[1]}-${widget.unpayedList.reversed.toList()[index].split('-')[0]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    fontFamily: "EBGaramond",
                  )),
            );
          },
        ),
      ),
    );
  }
}
