import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locataireapp/API_engine/notification_engine/delete_notification.dart';
import 'package:locataireapp/API_engine/notification_engine/query_notification_by_tenant_id.dart';

import '../../../colors/colorsrepertory.dart';
import '../../../model/notification.dart';
import '../../../model/property.dart';
import '../../../model/tenant.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key, required this.myTenant});

  final Tenant myTenant;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationM>? _notificationList;
  List<NotificationM>? get notificationList => _notificationList;
  set notificationList(List<NotificationM>? value) {
    setState(() {
      _notificationList = value;
    });
  }

  Map<String, Tenant?> tenantList = {};

  Map<String, Property?> propertyList = {};

  @override
  void initState() {
    super.initState();
    starNotificationSync();
  }

  void starNotificationSync() async {
    for (int i = 0; i < 3; i++) {
      if (i == 0) {
        notificationList = await queryAllNotificationByTenantID(
            widget.myTenant.tenantID.toString());

        setState(() {
          notificationList;
        });
      } else {
        await Future.delayed(const Duration(seconds: 3));
        notificationList = await queryAllNotificationByTenantID(
            widget.myTenant.tenantID.toString());

        setState(() {
          notificationList;
        });
      }
      print('ok');
      if (i == 2) {
        i = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return notificationList == null
        ? Center(
            child: CircularProgressIndicator(
              color: clr["blue"],
            ),
          )
        : FutureBuilder<List<NotificationM>>(
            future: Future.value(notificationList?.reversed.toList()),
            builder: (BuildContext context,
                AsyncSnapshot<List<NotificationM>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: clr["blue"],
                  ),
                );
              }
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Text("Pas de Notification ! ",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: clr["wWrite"],
                            fontSize: 32.sp,
                            fontFamily: "EBGaramond",
                          )),
                    )
                  : //Center(child: Lottie.asset("assets/lottie/Animation_no_result.json"),) :
                  ListView(
                      children: snapshot.data!.map((notification) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Slidable(
                            startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      print(
                                          "ok : ${notification.notificationID.toString()}");
                                      deleteNotification(notification
                                          .notificationID
                                          .toString());
                                    },
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: const Color(0xFFFE4A49),
                                    icon: FontAwesomeIcons.trashCan,
                                    label: 'Supprimer',
                                  ),
                                ]),
                            child: Container(
                              //height: size.height*.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: clr["blue"]!)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(notification.notifDate,
                                              style: TextStyle(
                                                fontFamily: "EBGaramond",
                                                fontSize: 15.sp,
                                                color: clr["blue"],
                                                fontWeight: FontWeight.bold,
                                              ))
                                        ],
                                      ),
                                      Text(notification.notifMessage,
                                          style: TextStyle(
                                            fontFamily: "EBGaramond",
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList());
            });
  }
}
