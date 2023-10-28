import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locataireapp/API_engine/tenant_engine/query_tenant_by_id.dart';
import 'package:locataireapp/screen/signLog/log.dart';
import 'package:locataireapp/service/bloc/update_picture_bloc.dart';

import '../../../API_engine/tenant_engine/update_tenant.dart';
import '../../../colors/colorsrepertory.dart';
import '../../../model/tenant.dart';
import '../../signLog/main_sign_log.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, required this.ourTenant});

  final Tenant ourTenant;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contact1Controller = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contact2Controller = TextEditingController();
  final TextEditingController _inscriptionDateController =
      TextEditingController();

  String get nameController => _nameController.text;
  String get contact1Controller => _contact1Controller.text;
  String get lastNameController => _lastNameController.text;
  String get contact2Controller => _contact2Controller.text;
  String get inscriptionDateController => _inscriptionDateController.text;

  final List<String> _avatarList = ["7309681", "f1", "h2", "f2", "h3", "f3"];
  List<String> get avatarList => _avatarList;

  String _avatar = "7309681";
  String get avatar => _avatar;
  set avatar(String value) {
    setState(() {
      _avatar = value;
    });
  }

  int? _isRegistring = -1;
  int? get isRegistring => _isRegistring;
  set isRegistring(int? value) {
    setState(() {
      _isRegistring = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Scaffold(
        body: SafeArea(
            child: Wrap(
      children: [
        BlocBuilder<UpdatePictureBloc, UpdatePictureState>(
          builder: (context, state) {
            return Column(children: [
              Text(
                "Profil",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  fontFamily: "EBGaramond",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: 225.h,
                    width: 225.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/avatar/${state.pic}.jpg")),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 300.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Nom : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: "EBGaramond",
                            ),
                          ),
                          Container(
                            width: 230.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: clr["blue"]!,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: clr["container"]?.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 8, left: 13),
                              child: TextFormField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontFamily: "EBGaramond",
                                    fontWeight: FontWeight.bold,
                                    color: clr["black"]?.withOpacity(0.7),
                                    fontSize: 16.sp),
                                keyboardType: TextInputType.name,
                                controller: _nameController,
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.ourTenant.tenantName,
                                  hintStyle: TextStyle(
                                      fontFamily: "EBGaramond",
                                      fontWeight: FontWeight.bold,
                                      color: clr["black"]?.withOpacity(0.7),
                                      fontSize: 16.sp),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 8) {
                                    return 'Veuillez entrer un contact de huit chiffres';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Prénoms : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: "EBGaramond",
                            ),
                          ),
                          Container(
                            width: 202.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: clr["blue"]!,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: clr["container"]?.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 13),
                              child: TextFormField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontFamily: "EBGaramond",
                                    fontWeight: FontWeight.bold,
                                    color: clr["black"]?.withOpacity(0.7),
                                    fontSize: 16.sp),
                                keyboardType: TextInputType.name,
                                controller: _lastNameController,
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.ourTenant.tenantLastName,
                                  hintStyle: TextStyle(
                                      fontFamily: "EBGaramond",
                                      fontWeight: FontWeight.bold,
                                      color: clr["black"]?.withOpacity(0.7),
                                      fontSize: 16.sp),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 8) {
                                    return 'Veuillez entrer un contact de huit chiffres';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Numéro moov : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: "EBGaramond",
                            ),
                          ),
                          Container(
                            width: 165.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: clr["blue"]!,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: clr["container"]?.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 13),
                              child: TextFormField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontFamily: "EBGaramond",
                                    fontWeight: FontWeight.bold,
                                    color: clr["black"]?.withOpacity(0.7),
                                    fontSize: 16.sp),
                                keyboardType: TextInputType.phone,
                                controller: _contact1Controller,
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.ourTenant.tenantContact1,
                                  hintStyle: TextStyle(
                                      fontFamily: "EBGaramond",
                                      fontWeight: FontWeight.bold,
                                      color: clr["black"]?.withOpacity(0.7),
                                      fontSize: 16.sp),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 8) {
                                    return 'Veuillez entrer un contact de huit chiffres';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Numéro TgCel : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: "EBGaramond",
                            ),
                          ),
                          Container(
                            width: 165.w,
                            height: 38.h,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: clr["blue"]!,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: clr["container"]?.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 5, left: 13),
                              child: TextFormField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontFamily: "EBGaramond",
                                    fontWeight: FontWeight.bold,
                                    color: clr["black"]?.withOpacity(0.7),
                                    fontSize: 16.sp),
                                keyboardType: TextInputType.phone,
                                controller: _contact2Controller,
                                decoration: InputDecoration.collapsed(
                                  hintText: widget.ourTenant.tenantContact2,
                                  hintStyle: TextStyle(
                                      fontFamily: "EBGaramond",
                                      fontWeight: FontWeight.bold,
                                      color: clr["black"]?.withOpacity(0.7),
                                      fontSize: 16.sp),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length != 8) {
                                    return 'Veuillez entrer un contact de huit chiffres';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<UpdatePictureBloc, UpdatePictureState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.height * .17,
                          width: size.width * .7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[0]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[0]}.jpg")),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[1]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[1]}.jpg")),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[2]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[2]}.jpg")),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[3]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[3]}.jpg")),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[4]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[4]}.jpg")),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<UpdatePictureBloc>(
                                              context)
                                          .add(SetUpdatePictureEvent(
                                              avatarList[5]));
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: //"assets/avatar/$avatar.jpg"
                                                AssetImage(
                                                    "assets/avatar/${avatarList[5]}.jpg")),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      isRegistring = null;
                      isRegistring = await updateTenant(
                          widget.ourTenant.tenantID.toString(),
                          nameController.length < 2
                              ? widget.ourTenant.tenantName
                              : nameController,
                          lastNameController.length < 2
                              ? widget.ourTenant.tenantLastName
                              : lastNameController,
                          contact1Controller.length < 2
                              ? widget.ourTenant.tenantContact1
                              : contact1Controller,
                          contact2Controller.length < 2
                              ? widget.ourTenant.tenantContact2
                              : contact2Controller,
                          inscriptionDateController);
                      queryTenantByID(widget.ourTenant.tenantID.toString());
                      if (isRegistring == 1) {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const MainSignLog()));
                      }
                    },
                    child: Container(
                        width: size.width * .4,
                        height: size.height * .06,
                        decoration: BoxDecoration(
                          color: clr["blue"],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Modifier  ",
                                style: TextStyle(
                                    fontFamily: "EBGaramond",
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: clr["wWrite"])),
                            isRegistring == -1
                                ? Container()
                                : isRegistring == null
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : isRegistring == 1
                                        ? FaIcon(
                                            FontAwesomeIcons.check,
                                            color: Colors.white,
                                            size: 30.sp,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.xmark,
                                            size: 30.sp,
                                            color: clr["blackBlue"],
                                          )
                          ],
                        )),
                  ),
                ],
              )
            ]);
          },
        ),
      ],
    )));
  }
}
