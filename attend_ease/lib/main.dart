import 'package:flutter/material.dart';
import 'detailPage.dart';

void main() => runApp(MaterialApp(
      home: MyHome(),
    ));

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<MyHome> {
  final List<Map<String, dynamic>> subjects = [
    {
      'subjectName': 'Mathematics',
      'totalClasses': 30,
      'attendedClasses': 20,
      'missedClasses': 10,
    },
    {
      'subjectName': 'Physics',
      'totalClasses': 25,
      'attendedClasses': 18,
      'missedClasses': 7,
    },
    {
      'subjectName': 'Chemistry',
      'totalClasses': 28,
      'attendedClasses': 22,
      'missedClasses': 6,
    },
    {
      'subjectName': 'Biology',
      'totalClasses': 32,
      'attendedClasses': 10,
      'missedClasses': 6,
    },
    {
      'subjectName': 'English',
      'totalClasses': 20,
      'attendedClasses': 18,
      'missedClasses': 2,
    },
  ];
  double calculateAttendancePercentage(int attend, int total) {
    return (attend / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var subject in subjects)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        subjectName: subject['subjectName'],
                        totalClasses: subject['totalClasses'],
                        attendedClasses: subject['attendedClasses'],
                        missedClasses: subject['missedClasses'],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text Information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subject: ${subject['subjectName']}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${subject['totalClasses']}  Total',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              '${subject['attendedClasses']}  Attended',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              '${subject['missedClasses']}  Missed',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: calculateAttendancePercentage(
                                      subject['attendedClasses'],
                                      subject['totalClasses']) /
                                  100,
                              strokeWidth: 6,
                              backgroundColor: Colors.grey[400],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                getColorBasedOnPercentage(
                                  calculateAttendancePercentage(
                                      subject['attendedClasses'],
                                      subject['totalClasses']),
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${calculateAttendancePercentage(subject['attendedClasses'], subject['totalClasses']).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddSubjectDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
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

  // the below method is holds the functionality for showing dialog
  void showAddSubjectDialog(BuildContext context) {
    final TextEditingController subjectNameController = TextEditingController();
    final TextEditingController subjectCodeController = TextEditingController();
    final TextEditingController totalHoursController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Add New Subject",
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: subjectNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: subjectCodeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Subject Code',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: totalHoursController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Total Hours',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without adding
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Create a new subject and add it to the list
                setState(() {
                  subjects.add({
                    'subjectName': subjectNameController.text,
                    'subjectCode': subjectCodeController.text,
                    'totalClasses': int.parse(totalHoursController.text),
                    'attendedClasses': 0,
                    'missedClasses': 0,
                  });
                });

                // Close the dialog after adding the new subject
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
