import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neurooooo/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  testWidgets('Calendar Page Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CalendarPage(),
    ));

    // Verify that the title text is rendered correctly
    expect(find.text('Calendar'), findsOneWidget);

    // Tap on the calendar to select a day
    await tester.tap(find.byType(TableCalendar));
    await tester.pump();

    // Verify that the selected day text is displayed
    expect(find.textContaining('Selected Day:'), findsOneWidget);
  });
}
