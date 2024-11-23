import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailPage extends StatelessWidget {
  final String subjectName;
  final int totalClasses;
  final int attendedClasses;
  final int missedClasses;

<<<<<<< Updated upstream
  const DetailPage({
=======
  Map<DateTime, List<String>> highlightedDates = {
    DateTime(2023, 6, 1): ['Attended'],
    DateTime(2023, 6, 5): ['Missed'],
    DateTime(2023, 6, 10): ['Attended'],
    DateTime(2023, 6, 15): ['Holiday'],
  };

  DetailPage({
>>>>>>> Stashed changes
    super.key,
    required this.subjectName,
    required this.totalClasses,
    required this.attendedClasses,
    required this.missedClasses,
  });

  double calculateAttendancePercentage(int attended, int total) {
    return (attended / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime(2023, 1, 1);
    final DateTime lastDay = DateTime(2023, 12, 31);
    final DateTime focusedDay = DateTime(2023, 6, 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Classes: $totalClasses',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Classes Attended: $attendedClasses',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Classes Missed: $missedClasses',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            Text(
              'Attendance Percentage: ${calculateAttendancePercentage(attendedClasses, totalClasses).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Class Attendance Calendar:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: calculateAttendancePercentage(
                            attendedClasses, totalClasses) /
                        100,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[400],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      getColorBasedOnPercentage(
                        calculateAttendancePercentage(
                            attendedClasses, totalClasses),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${calculateAttendancePercentage(attendedClasses, totalClasses).toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TableCalendar(
              firstDay: firstDay,
              lastDay: lastDay,
              focusedDay: focusedDay,
              calendarBuilders: CalendarBuilders(
                // Custom builder for the day cell
                defaultBuilder: (context, date, focusedDay) {
                  DateTime normalizedDate =
                      DateTime(date.year, date.month, date.day);
                  if (highlightedDates.containsKey(normalizedDate)) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green, // Highlight color for the number
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text(
                      '${date.day}',
                      style: const TextStyle(
                        fontSize:
                            16, // Ensure the regular date size remains unchanged
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false, // Hides the format button
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent, // Color for the month and year text
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.blueAccent, // Color for the left arrow
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.blueAccent, // Color for the right arrow
                ),
                titleCentered: true, // Centers the month/year text
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue, // Color for today's date
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.green, // Color for the selected date
                  shape: BoxShape.circle,
                ),
                weekendTextStyle:
                    TextStyle(color: Colors.yellow), // Color for weekend dates
                defaultTextStyle:
                    TextStyle(color: Colors.white), // Color for regular dates
                outsideDaysVisible: false,
                holidayTextStyle:
                    TextStyle(color: Colors.orange), // Color for holiday dates

                markerSizeScale: 0.4,
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle:
                    TextStyle(color: Colors.yellow), // Color for weekend labels
                weekdayStyle:
                    TextStyle(color: Colors.white), // Color for weekday labels
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorBasedOnPercentage(double percentage) {
    if (percentage >= 75) {
      return Colors.green;
    } else if (percentage >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
