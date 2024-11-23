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
        title: const Text(
          "Attendance",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[900], // Slightly lighter than black
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
                  height: 180,
                  padding: const EdgeInsets.all(20),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[700], // Improved box background color
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                       Transform.translate(
                         offset: Offset(280,-10),
                       child: IconButton(
                          alignment: Alignment.topRight,
                          onPressed: () {
                            showReomve(context, subject, (subjectToRemove) {
                              setState(() {
                                subjects.remove(subjectToRemove);
                              });
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),

                      Row(
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
                                    fontSize: 18,
                                    color: Colors.white, // High contrast text
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${subject['totalClasses']} Total',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300], // Softer white
                                  ),
                                ),
                                Text(
                                  '${subject['attendedClasses']} Attended',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text(
                                  '${subject['missedClasses']} Missed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Circular Progress Bar on the right
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
                                  strokeWidth: 8,
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
                      // Delete Icon on top right
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: IconButton(
                      //     alignment: Alignment.center,
                      //     onPressed: () {
                      //       showReomve(context, subject, (subjectToRemove) {
                      //         setState(() {
                      //           subjects.remove(subjectToRemove);
                      //         });
                      //       });
                      //     },
                      //     icon: const Icon(Icons.delete,
                      //         color: Colors.white),
                      //   ),
                      // ),
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
        child: const Icon(Icons.add, color: Colors.white),
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

  void showAddSubjectDialog(BuildContext context) {
    final TextEditingController subjectNameController = TextEditingController();
    final TextEditingController subjectCodeController = TextEditingController();
    final TextEditingController totalHoursController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
          Colors.grey[850], // Dark but lighter dialog background
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
                decoration: InputDecoration(
                  labelText: 'Subject Name',
                  labelStyle: TextStyle(color: Colors.grey[300]),
                ),
              ),
              TextField(
                controller: subjectCodeController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Subject Code',
                  labelStyle: TextStyle(color: Colors.grey[300]),
                ),
              ),
              TextField(
                controller: totalHoursController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Total Hours',
                  labelStyle: TextStyle(color: Colors.grey[300]),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.white))),
            TextButton(
              onPressed: () {
                setState(() {
                  subjects.add({
                    'subjectName': subjectNameController.text,
                    'subjectCode': subjectCodeController.text,
                    'totalClasses': int.parse(totalHoursController.text),
                    'attendedClasses': 0,
                    'missedClasses': 0,
                  });
                });
                Navigator.pop(context);
              },
              child:
              const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

// Remove function with callback support
void showReomve(BuildContext context, Map<String, dynamic> subject,
    Function(Map<String, dynamic>) removeSubject) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[850],
        title: const Text(
          "Remove Subject",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to remove this subject?',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            child: const Text("No", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("Yes", style: TextStyle(color: Colors.white)),
            onPressed: () {
              removeSubject(subject);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}