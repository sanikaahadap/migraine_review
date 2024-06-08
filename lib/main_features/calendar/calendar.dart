//MODULE NOT REQUIRED ANYMORE

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF16666B),
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
                titleTextStyle: const TextStyle(color: Color(0xFF16666B)),
                formatButtonDecoration: BoxDecoration(
                  color: const Color(0xFF16666B),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                formatButtonTextStyle: const TextStyle(color: Colors.white),
              ),
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(color: Color(0xFF16666B)),
                todayTextStyle: const TextStyle(color: Colors.white),
                selectedTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: const TextStyle(color: Color(0xFF16666B)),
                outsideTextStyle: TextStyle(color: const Color(0xFF16666B).withOpacity(0.5)),
                outsideDaysVisible: false,
                todayDecoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF16666B)),
                selectedDecoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF16666B)),
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
            const SizedBox(height: 20),
            _selectedDay != null
                ? Text(
              'Selected Day: ${_selectedDay!.toString().substring(0, 10)}',
              style: const TextStyle(fontSize: 18, color: Color(0xFF16666B)),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
