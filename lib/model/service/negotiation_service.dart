import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:office_management/model/service.dart';
import 'package:office_management/model/article.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class NegotiationService extends Service {
  DateTime _currentDate;


  NegotiationService({String name, String description})
      : super(name: name, description: description);

  void setCalendarDate(DateTime date) {
    _currentDate = date;
  }

  @override
  Widget build(BuildContext context) {
     return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel(
        weekDays: ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'],
        //onDayPressed: (DateTime date) {this.setCalendarDate(date);},
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
       /* headerText: Container( /// Example for rendering custom header
          child: Text('Custom Header'),
        ),*/
        weekFormat: false,
        weekends: [WeekDay.Sunday, WeekDay.Saturday],
        //markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false,
        selectedDayTextStyle:	TextStyle(fontSize: 14.0, color: Colors.white),
        selectedDayBorderColor:	Colors.green,
        selectedDayButtonColor:	Colors.green,
      ),
    );
  }
}
