import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calendar',
          style: TextStyle(color: Color(0xFF16666B)),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Color(0xFF16666B)),
                formatButtonDecoration: BoxDecoration(
                  color: Color(0xFF16666B),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: Color(0xFF16666B)),
                todayTextStyle: TextStyle(color: Colors.white),
                selectedTextStyle: TextStyle(color: Colors.white),
                weekendTextStyle: TextStyle(color: Color(0xFF16666B)),
                outsideTextStyle: TextStyle(color: Color(0xFF16666B).withOpacity(0.5)),
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF16666B)),
                selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF16666B)),
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
            SizedBox(height: 20),
            _selectedDay != null
                ? Text(
              'Selected Day: ${_selectedDay!.toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18, color: Color(0xFF16666B)),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
