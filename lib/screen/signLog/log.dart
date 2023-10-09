import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locataireapp/API_engine/tenant_engine/query_all_tenant.dart';
import 'package:locataireapp/model/tenant.dart';
import 'package:locataireapp/screen/mainsScreen/page_scroller.dart';

import '../../colors/colorsrepertory.dart';
import '../../service/cubit/sign_log_cubit.dart';

class Log extends StatefulWidget {
  const Log({super.key});

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  final _formKey = GlobalKey<FormState>();

  List<Tenant?> _myTenantList = [];
  List<Tenant?> get myTenantList => _myTenantList;
  set  myTenantList(List<Tenant?> value){
    setState(() {
      _myTenantList = value;
    });
  }

  Tenant? _myTenant;
  Tenant? get myTenant => _myTenant;
  set  myTenant(Tenant? value){
    setState(() {
      _myTenant = value;
    });
  }

  int _isAllTenant = 0;
  int get isAllTenant => _isAllTenant;
  set isAllTenant(int value) {
    setState(() => _isAllTenant = value);
  }
  final TextEditingController _numMoovController = TextEditingController();
  final TextEditingController _numTgcelController = TextEditingController();
  String get numMoovController => _numMoovController.text;
  String get numTgcelController=> _numTgcelController.text ;
  int pwdVisibity = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Form(
    key: _formKey,
      child: Column(
        children: [
          Container(
            width: 300.w,
            height: 48.h,
            decoration: BoxDecoration(
                border: Border.all(
                    color: clr["blue"]!, width: 1.0, style: BorderStyle.solid),
                color: clr["container"]?.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15)),
            child: Container(
              margin: const EdgeInsets.only(top: 13, left: 13),
              child: TextFormField(
                onTap: () async {
                  isAllTenant++;
                  if(isAllTenant == 1){
                    myTenantList = await queryAllTenats();
                  }
                },
                keyboardType: TextInputType.phone,
                controller: _numMoovController,
                decoration: InputDecoration.collapsed(
                  hintText: "Numéro moov...",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold,
                    fontFamily: 'EBGaramond',
                      color: clr["black"]?.withOpacity(0.7), fontSize: 18.sp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length !=8) {
                    return 'Veuillez entrer numéro Moov';
                  }
                  return null;
                },
              ),
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
                    onTap: () async {
                  isAllTenant++;
                  if(isAllTenant == 1){
                    myTenantList = await queryAllTenats();
                  }
                },
                    keyboardType: TextInputType.phone,
                    controller: _numTgcelController,
                    
                    decoration: InputDecoration.collapsed(
                      hintText: "Numero Tgcel...",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'EBGaramond',
                          color: clr["black"]?.withOpacity(0.7), fontSize: 18.sp),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length !=8) {
                        return 'Veuillez entrer numéro Tegcel';
                      }
                      return null;
                    },
                  ),
                ),
                
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          /*Row(
            children: [
              BlocBuilder<SignLogCubit, int>(
                builder: (context, state) {
                  return Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                          onTap: () {
                            context.read<SignLogCubit>().increment();
                          },
                          child: Text("Sign up",
                              style: TextStyle(
                                fontFamily: 'EBGaramond',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: clr["blue"]))));
                },
              )
            ],
          ),*/
          Container(
            height: 20,
          ),
          GestureDetector(
            onTap :() {
              print("ontap");
              try {
                if(_formKey.currentState!.validate() && myTenantList.isNotEmpty){
                myTenantList.forEach((element) {
                  if(element!.tenantContact1 == numMoovController  || element.tenantContact2 == numTgcelController){
                    myTenant = element;
                    }
                });
                
              } 
              } catch (e) {
                print("e : ${e}"); 
              }
              if (myTenant != null) {
                Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        PageScroller(myTenant: myTenant!,)));
              }
              
          },
            child: Container(
                width: 200.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: clr["blue"],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text("Log in ",
                        style: TextStyle(
                          fontFamily: 'EBGaramond',
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: clr["wWrite"])))),
          ),
        ],
      ),
    );
  }
}
