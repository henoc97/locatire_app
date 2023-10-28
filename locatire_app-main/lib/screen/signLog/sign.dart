import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/colorsrepertory.dart';
import '../../service/cubit/sign_log_cubit.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  List<TextEditingController> fristLignTextCtrl = [
    for (int i = 0; i < 3; i++) TextEditingController(),
  ];
  List<TextEditingController> secondLignTextCtrl = [
    for (int i = 0; i < 3; i++) TextEditingController(),
  ];

  List<String> fristLignStrings = ["Nom", "Contact 1", "Mot de Passe"];
  List<String> secondLignStrings = ["Prénom", "Contact 2", "Confirmer le Pwd"];
  int pwdVisibity = 1;
  int pwdVisibity1 = 1;
  int signStepCtrl = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Column(
      children: [
        Container(
          width: 300.w,
          height: 48.h,
          decoration: BoxDecoration(
              border: Border.all(
                  color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
              color: clr["container"]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 220.w,
                margin: const EdgeInsets.only(top: 13, left: 13),
                child: TextFormField(
                  controller: fristLignTextCtrl[signStepCtrl],
                  obscureText: pwdVisibity % 2 == 1 ? true : false,
                  decoration: InputDecoration.collapsed(
                    hintText: "${fristLignStrings[signStepCtrl]}...",
                    hintStyle: TextStyle(fontFamily: 'EBGaramond',fontWeight: FontWeight.bold,
                        color: clr["black"]?.withOpacity(0.7), fontSize: 18.sp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le mot de passe';
                    }
                    return null;
                  },
                ),
              ),
              signStepCtrl == 2
                  ? IconButton(
                      iconSize: 25.sp,
                      onPressed: () {
                        setState(() {
                          pwdVisibity++;
                        });
                      },
                      icon: Icon(pwdVisibity % 2 == 0
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined))
                  : Container(),
            ],
          ),
        ),
        Container(
          height: 20,
        ),
        Container(
          width: 300.w,
          height: 48.h,
          decoration: BoxDecoration(
              border: Border.all(
                  color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
              color: clr["container"]?.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 13, left: 13),
                width: 220.w,
                child: TextFormField(
                  controller: secondLignTextCtrl[signStepCtrl],
                  obscureText: pwdVisibity % 2 == 1 ? true : false,
                  decoration: InputDecoration.collapsed(
                    hintText: "${secondLignStrings[signStepCtrl]}...",
                    hintStyle: TextStyle(fontFamily: 'EBGaramond',fontWeight: FontWeight.bold,
                        color: clr["black"]?.withOpacity(0.7), fontSize: 18.sp),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le mot de passe';
                    }
                    return null;
                  },
                ),
              ),
              signStepCtrl == 2
                  ? IconButton(
                      iconSize: 25.sp,
                      onPressed: () {
                        setState(() {
                          pwdVisibity1++;
                        });
                      },
                      icon: Icon(pwdVisibity1 % 2 == 0
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined))
                  : Container(),
            ],
          ),
        ),
        Container(
          height: 20,
        ),
        Row(
          children: [
            BlocBuilder<SignLogCubit, int>(
              builder: (context, state) {
                return Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                        onTap: () {
                          context.read<SignLogCubit>().increment();
                        },
                        child: Text("Log in",
                            style: TextStyle(
                              fontFamily: 'EBGaramond',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: clr["blue"]))));
              },
            )
          ],
        ),
        Container(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (signStepCtrl > 0) {
                    signStepCtrl--;
                  }
                });
              },
              child: Container(
                  width: 150.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: clr["blue"],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: Text("Précédent",
                          style: TextStyle(fontFamily: 'EBGaramond',
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: clr["wWrite"])))),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (signStepCtrl < 2) {
                    signStepCtrl++;
                  }
                });
              },
              child: Container(
                  width: 150.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: clr["blue"],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: Text(signStepCtrl == 2 ? "Sign in" : "Suivant",
                          style: TextStyle(fontFamily: 'EBGaramond',
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: clr["wWrite"])))),
            ),
          ],
        ),
      ],
    );
  }
}
