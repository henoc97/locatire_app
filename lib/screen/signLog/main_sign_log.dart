import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../colors/colorsrepertory.dart';
import '../../service/cubit/sign_log_cubit.dart';
import 'log.dart';
import 'sign.dart';

class MainSignLog extends StatefulWidget {
  const MainSignLog({super.key});

  @override
  State<MainSignLog> createState() => _MainSignLogState();
}

class _MainSignLogState extends State<MainSignLog> {
  String title = "";
  int titleIndex = 0;
  final String targetTitle = "Miabé Ahomé !  ";

  @override
  void initState() {
    super.initState();
    starAnimation();
  }

  void starAnimation() async {
    for (int i = 0; i < targetTitle.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        titleIndex = i;
        title = targetTitle.substring(0, titleIndex + 1);
      });
      if (i == targetTitle.length - 1) {
        i = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Scaffold(
      backgroundColor: clr["white"],
      body: Wrap(
        children: [
          BlocBuilder<SignLogCubit, int>(
            builder: (context, state) {
              return Column(children: [
                SizedBox(height: size.height*.55, child: Lottie.asset("assets/lottie/animation_house .json")),
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'EBGaramond',
                      fontSize: 35.sp,
                      color: clr["blackBlue"]?.withOpacity(0.7),
                      fontWeight: FontWeight.bold),
                ),
                state%2==0? const Log(): const Sign() 
              ]);
            },
          ),
        ],
      ),
    );
  }
}
