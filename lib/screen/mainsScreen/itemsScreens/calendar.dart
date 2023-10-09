import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../colors/colorsrepertory.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {
  DateTime(2023, 9, 15): [Event("Réunion", "Réunion d'équipe"), Event("Conférence", "Conférence importante")],
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
            availableCalendarFormats:const {
              CalendarFormat.month:"Mois",
              CalendarFormat.week:"Semaine"
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: clr["blue"], borderRadius: BorderRadius.circular(7)),
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
                       // height: size.height * .06.h,
                        width: size.width * .8.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: size.width*.7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ' Paiement du moi prochain dans 1 moi 5jours',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 3.5),
                                height: size.height * .07.h,
                                width: size.width * .15.w,
                                decoration: BoxDecoration(
                                    color: clr["blue"],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(child: FaIcon(FontAwesomeIcons.xmark, color: clr["blackBlue"],size: 30.sp,))),
                          ],
                        ),
                      ),
                    ),
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
                       // height: size.height * .06.h,
                        width: size.width * .10.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: size.width*.7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ' Paiement de ce moi dans 5jours',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 3.5),
                                height: size.height * .07.h,
                                width: size.width * .15.w,
                                decoration: BoxDecoration(
                                    color: clr["blue"],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(child: FaIcon(FontAwesomeIcons.xmark, color: clr["blackBlue"],size: 30.sp,))),
                          ],
                        ),
                      ),
                    ),
    
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
                        //height: size.height * .06.h,
                        width: size.width * .8.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(width: size.width*.7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ' Paiement précédent fait il y a de cela 1 moi 16 jours',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 3.5),
                                height: size.height * .07.h,
                                width: size.width * .15.w,
                                decoration: BoxDecoration(
                                    color: clr["blue"],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(child: FaIcon(FontAwesomeIcons.check, color: clr["blackBlue"],size: 30.sp,))),
                          ],
                        ),
                      ),
                    ),
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