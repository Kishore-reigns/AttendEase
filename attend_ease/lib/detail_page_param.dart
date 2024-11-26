import 'package:attend_ease/adminMain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SubDetailedPage_Param extends StatefulWidget {
  // final String subjectCode;
  // final String subjectName;
  // final int contactHours;
  // final int hoursAttended;
  // final int missedClasses;

  Map<String, dynamic> subject;
  // Constructor for the StatefulWidget
  SubDetailedPage_Param({
    required this.subject,
  });

  @override
  _SubDetailedPage_ParamState createState() => _SubDetailedPage_ParamState();
}

class _SubDetailedPage_ParamState extends State<SubDetailedPage_Param> {
  double screenWidth = 0.0;
  int counter = 0; // This is for the class counter in the dialog

  final Color col = Colors.grey.withOpacity(0.7);
  final Color backgroundColor = Color.fromRGBO(18, 18, 18, 1);
  final Color foregroundColor = Color.fromRGBO(30, 30, 30, 1);

  // final Map<DateTime, List<String>> highlightedDates = {
  //   DateTime(2023, 6, 1): ['Attended'],
  //   DateTime(2023, 6, 5): ['Missed'],
  //   DateTime(2023, 6, 10): ['Attended'],
  //   DateTime(2024, 11, 15): ['Holiday'],
  // };

  final Map<DateTime, List<int>> highlightedDates = {
    DateTime(2023, 6, 1): [5, 6], // ( Attended that day , Total that day )
    DateTime(2023, 6, 5): [6, 8],
    DateTime(2023, 6, 10): [5, 5],
    DateTime(2024, 11, 15): [6, 9],
  };

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return getFullBody(context);
  }

  double calculateAttendancePercentage() {
    int totalAttended =
        highlightedDates.values.fold(0, (sum, value) => sum + value[0]);
    int contactHours =
        highlightedDates.values.fold(0, (sum, value) => sum + value[1]);
    return contactHours > 0 ? (totalAttended / contactHours) * 100 : 0.0;
  }

  Scaffold getFullBody(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: createFloatingButtonsDouble(context),
      body: ListView(
        children: [
          createAppBar(),
          subjectDetailsContainer(),
          createCircleProgress(),
          createCustomCalendar(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Container createFloatingButtonsDouble(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          SizedBox(width: screenWidth / 20 + 3.0),
          SizedBox(
            height: 50,
            width: screenWidth / 2.30,
            child: ElevatedButton(
              onPressed: () {
                showRemoveClassDialog(context);
              },
              child: const Text('Remove Class', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          SizedBox(
            height: 50,
            width: screenWidth / 2.30,
            child: ElevatedButton(
              onPressed: () {
                showAddClassDialog(context);
              },
              child: const Text('Add Class', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAddClassDialog(BuildContext context) {
    TextEditingController counterController =
        TextEditingController(text: counter.toString());
    DateTime? selectedDate;
    String attendanceStatus = 'Attended'; // Default value
    int hoursAttended = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: foregroundColor,
              title: Text(
                'Add Class',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  counterCreator(setDialogState, counterController),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setDialogState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: attendanceStatus,
                    dropdownColor: backgroundColor,
                    items: [
                      DropdownMenuItem(
                        value: 'Attended',
                        child: Text(
                          'Attended',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Partially Attended',
                        child: Text(
                          'Partially Attended',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Missed',
                        child: Text(
                          'Missed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      // print("Onnum Panna Vendam if DropDown val Changed");
                      setDialogState(() {
                        attendanceStatus = value!;
                        // int hoursAttended=0;
                        // if (attendanceStatus == 'Attended') {
                        //   hoursAttended = int.parse(counterController.text);
                        // }else if(attendanceStatus == 'Missed'){
                        //   hoursAttended = 0;
                        // }
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedDate == null || counterController.text == '0') {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Please select a date and number of classes'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (attendanceStatus == 'Partially Attended') {
                      showPartialAttendanceDialog(context, (int attended) {
                        setState(() {
                          int contactHours = int.parse(counterController.text);
                          print(
                              'For Partial setting as : ($attended,$contactHours)');
                          highlightedDates[selectedDate!] = [
                            attended,
                            contactHours
                          ];
                        });
                        Navigator.of(context).pop();
                      });
                    } else if (attendanceStatus == 'Attended') {
                      setState(() {
                        highlightedDates[selectedDate!] = [
                          int.parse(counterController.text),
                          int.parse(counterController.text)
                        ];
                      });
                      Navigator.of(context).pop();
                    } else if (attendanceStatus == 'Missed') {
                      setState(() {
                        highlightedDates[selectedDate!] = [
                          0,
                          int.parse(counterController.text)
                        ];
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void showPartialAttendanceDialog(BuildContext context, Function(int) onSave) {
    TextEditingController attendedCounterController =
        TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: foregroundColor,
              title: Text(
                'Enter No. of Classes Attended',
                style: TextStyle(color: Colors.white),
              ),
              content:
                  counterCreator(setDialogState, attendedCounterController),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    int attended =
                        int.tryParse(attendedCounterController.text) ?? 0;
                    if (attended <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Attended classes must be greater than 0'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    onSave(attended);
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void createPopUpJustForCount(
      context, attendedCounterController, selectedDate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setDialogState) {
            return AlertDialog(
                backgroundColor: foregroundColor,
                title: Text(
                    'No. of classes attended on ${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'),
                content: Column(children: [
                  counterCreator(setDialogState, attendedCounterController),
                  const SizedBox(
                    height: 10,
                  ),
                ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ))
                ]);
          });
        });
  }

  void showRemoveClassDialog(BuildContext context) {
    List<DateTime> datesToRemove = highlightedDates.keys.toList();
    List<bool> selectedDates = List.filled(datesToRemove.length, false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: foregroundColor,
              title:
                  Text('Remove Class', style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...datesToRemove.asMap().entries.map((entry) {
                    int index = entry.key;
                    DateTime date = entry.value;
                    return CheckboxListTile(
                      value: selectedDates[index],
                      onChanged: (bool? value) {
                        setDialogState(() {
                          selectedDates[index] = value!;
                        });
                      },
                      title: Text(
                        '${date.toIso8601String().split('T').first} - ${highlightedDates[date]?.first ?? ''}',
                        style: TextStyle(color: Colors.white),
                      ),
                      activeColor: Colors.red,
                    );
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < selectedDates.length; i++) {
                        if (selectedDates[i]) {
                          // Remove selected dates
                          highlightedDates.remove(datesToRemove[i]);
                        }
                      }
                    });
                    // Placeholder for database update
                    print('Send removed dates to backend: $datesToRemove');
                    Navigator.of(context).pop();
                  },
                  child: Text('Remove'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Row counterCreator(
      StateSetter setDialogState, TextEditingController counterController) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            setDialogState(() {
              if (counter > 0) counter--;
              counterController.text = '$counter';
            });
          },
        ),
        Container(
          width: 130,
          child: TextField(
            controller: counterController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'No. of Classes',
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              setDialogState(() {
                counter = int.tryParse(value) ?? 0;
                if (counter > 30) {
                  counter = 30;
                }
              });
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          style: ButtonStyle(),
          onPressed: () {
            setDialogState(() {
              counter++;
              if (counter > 30) {
                counter = 30;
              }
              counterController.text = '$counter';
            });
          },
        ),
      ],
    );
  }

  TableCalendar<dynamic> createCustomCalendar() {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(2023, 12, 1),
      lastDay: DateTime(2025, 12, 1),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, focusedDay) {
          DateTime normalizedDate = DateTime(date.year, date.month, date.day);
          if (highlightedDates.containsKey(normalizedDate)) {
            Color circleColor = Colors.green;

            if (highlightedDates[normalizedDate]?[0] == 0)
              circleColor = Colors.red;
            else if (((highlightedDates[normalizedDate]?[0])! -
                    (highlightedDates[normalizedDate]![1])) ==
                0)
              circleColor = Colors.green;
            else
              circleColor = Colors.orange;

            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: Text(
              '${date.day}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.blueAccent),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.blueAccent),
        titleCentered: true,
      ),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: TextStyle(color: Colors.yellow),
        defaultTextStyle: TextStyle(color: Colors.white),
        outsideDaysVisible: false,
        holidayTextStyle: TextStyle(color: Colors.orange),
        markerSizeScale: 0.4,
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.yellow),
        weekdayStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  Container createCircleProgress() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 180,
      child: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: calculateAttendancePercentage() / 100,
                // value: calculateAttendancePercentage(widget.hoursAttended, widget.contactHours) / 100,
                strokeWidth: 6,
                backgroundColor: Colors.grey[400],
                valueColor: AlwaysStoppedAnimation<Color>(
                  getColorBasedOnPercentage(calculateAttendancePercentage()),
                  // getColorBasedOnPercentage(calculateAttendancePercentage(widget.hoursAttended, widget.contactHours)),
                ),
              ),
              Center(
                child: Text(
                  '${calculateAttendancePercentage().toStringAsFixed(1)}%',
                  // '${calculateAttendancePercentage(widget.hoursAttended, widget.contactHours).toStringAsFixed(1)}%',
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
      ),
    );
  }

  Container subjectDetailsContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: col,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject Code: ${widget.subject['subjectCode']}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            'Subject Name: ${widget.subject['subjectName']}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            'Classes Conducted: ${widget.subject['contactHours']}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            'Classes Attended: ${widget.subject['hoursAttended']}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          redTextBoxContainer('Classes Missed: '),
        ],
      ),
    );
  }

  Container redTextBoxContainer(String textToFill) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 196, 14, 14),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        '$textToFill${widget.subject['missedClasses']}',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  Container createAppBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: col,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${widget.subject['subjectName']}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }

  Color getColorBasedOnPercentage(double percentage) {
    if (percentage >= 75) {
      return Color.fromRGBO(51, 255, 13, 1);
    } else if (percentage >= 50) {
      return Color.fromRGBO(255, 176, 9, 1);
    } else {
      return Color.fromRGBO(255, 31, 31, 1);
    }
  }
}
