import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../API_engine/received_engine/query_received_by_tenant_id.dart';
import '../../../colors/colorsrepertory.dart';
import '../../../model/received.dart';
import '../../../model/tenant.dart';
import '../../../myfunctions/current_date.dart';
import 'unpayed_container.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.myTenant});

  final Tenant myTenant;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<List<String>> unpayedList = [];
  bool _showUnpayed = false;
  bool get showUnpayed => _showUnpayed;
  set showUnpayed(bool value) {
    setState(() {
      _showUnpayed = value;
    });
  }

  String _payDate = "";
  String get payDate => _payDate;
  set payDate(String value) {
    setState(() {
      _payDate = value;
    });
  }

  @override
  void initState() {
    super.initState();
    generateUnpayedMonth();
  }

  void generateUnpayedMonth() async {
    String endDate =
        "${formatDate(DateTime.now())[0]}/${formatDate(DateTime.now())[1]}/${formatDate(DateTime.now())[2]}";
    List<String> endDateList = endDate.split('/');
    DateTime end = DateTime.utc(int.parse(endDateList[2]),
        int.parse(endDateList[1]), int.parse(endDateList[0]));

    //print(eletTenant.tenantName);
    var eletTenant = widget.myTenant;
    var dateBetween = [];
    var payDateList = [];
    List<String> startDateList = eletTenant.inscriptionTenantDate.split('/');
    DateTime start = DateTime.utc(int.parse(startDateList[2]),
        int.parse(startDateList[1]), int.parse(startDateList[0]));
    while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
      var start1 = start.add(const Duration(days: 30));
      payDateList.add(start1.toString().substring(0, 10));
      dateBetween.add(start.toString().substring(0, 7));
      start = start.add(const Duration(days: 30)); // Ajoute un mois
    } //print(dateBetween);print(dateBetween.length);
    payDate = payDateList.last;
    print("payDate : $payDate");

    try {
      var tenantReceived =
          await querymyReceivedByTenantID(eletTenant.tenantID.toString());
      var datePayed = [];
      for (Received elttenantReceived in tenantReceived) {
        List<String> paymentReceivedDateList =
            elttenantReceived.monthPayed.split("/");
        String paymentReceivedDate =
            "${paymentReceivedDateList[1]}-${paymentReceivedDateList[0]}";
        datePayed.add(paymentReceivedDate);
      }
      Set<String> ensemble1 = Set.from(dateBetween);
      print(ensemble1);
      ensemble1.remove(ensemble1.last);
      Set<String> ensemble2 = Set.from(datePayed);
      print(ensemble2);
      ensemble1.removeAll(ensemble2);
      List<String> reponse = ensemble1.toList()..sort();

      print("dateBetweenLast : $reponse");
      print("dateBetweenLast : ${reponse.length}");
      unpayedList.add(reponse);

      setState(() {
        unpayedList;
      });
    } catch (e) {
      print('e $e');
    }
  }

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {
    DateTime(2023, 9, 15): [
      Event("Réunion", "Réunion d'équipe"),
      Event("Conférence", "Conférence importante")
    ],
    DateTime(2023, 9, 20): [Event("Anniversaire", "Anniversaire de John")],
    // Ajoutez d'autres dates et événements selon vos besoins
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, Color> clr = ColorsRepertory().colorApp;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2018, 1, 1),
            lastDay: DateTime.utc(2035, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: "Mois",
              CalendarFormat.week: "Semaine"
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                  color: clr["blue"], borderRadius: BorderRadius.circular(7)),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Jour du paiment du loyer de ce mois : ${payDate.split('-')[2]}-${payDate.split('-')[1]}-${payDate.split('-')[0]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  fontFamily: "EBGaramond",
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Les impayés",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      fontFamily: "EBGaramond",
                    )),
                IconButton(
                    onPressed: () {
                      showUnpayed = !showUnpayed;
                    },
                    icon: showUnpayed
                        ? const FaIcon(FontAwesomeIcons.angleUp)
                        : const FaIcon(FontAwesomeIcons.angleDown))
              ],
            ),
          ),
          showUnpayed
              ? SizedBox(
                  height: size.height * .48,
                  child: unpayedList.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: clr["blue"],
                          ),
                        )
                      : ListView.builder(
                          itemCount: unpayedList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UnpayedContainer(
                              clr: clr,
                              size: size,
                              unpayedList: unpayedList[index],
                            );
                          },
                        ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  Event(this.title, this.description);
}
