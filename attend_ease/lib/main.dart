import 'package:attend_ease/HTTP_Request/Http_connector.dart';
import 'package:attend_ease/detail_page_param.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MaterialApp(
  home: MyHome(),
));

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<MyHome> {
  String? regno ;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }


  Future<void> _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      regno = prefs.getString('registerNumber');

    });
  }

  Future<void> _refreshSubjects() async {
    List<Map<String, dynamic>> updatedSubjects = await initializeSubjects();
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // This will refresh the UI with the latest subjects
      // Any subjects added will now be displayed

      // Initialize regno here if needed
      // regno = prefs.getString('registerNumber');

    });
  }

  Future<List<Map<String, dynamic>>> initializeSubjects() async {
    HttpConnector conn = HttpConnector();
    try {
      List<Map<String, dynamic>> subs = await conn.fetchStudentSubjects(regno.toString());

      for (var subject in subs) {
        int contactHours = subject['contactHours'] ?? 0;
        int hoursAttended = subject['hoursAttended'] ?? 0;
        subject['missedClasses'] = contactHours - hoursAttended;
      }

      return subs;
    } catch (e) {
      throw Exception('Failed to load subjects: $e');
    }
  }

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const Profile()));
            },
            icon: const Icon(Icons.man),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: initializeSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'ADD SUBJECTS',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No subjects found',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final subjects = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var subject in subjects)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubDetailedPage_Param(
                              subject: subject,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Subject: ${subject['subjectName']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${subject['contactHours']} Total',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      Text(
                                        '${subject['hoursAttended']} Attended',
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
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CircularProgressIndicator(
                                        value: calculateAttendancePercentage(
                                            subject['hoursAttended'],
                                            subject['contactHours']) /
                                            100,
                                        strokeWidth: 10,
                                        backgroundColor: Colors.grey[400],
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          getColorBasedOnPercentage(
                                            calculateAttendancePercentage(
                                                subject['hoursAttended'],
                                                subject['contactHours']),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          '${calculateAttendancePercentage(subject['hoursAttended'], subject['contactHours']).toStringAsFixed(1)}%',
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
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddSubjectDialog(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
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
          backgroundColor: Colors.grey[850],
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
              child: const Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  // Add logic to update subjects dynamically if needed
                  HttpConnector conn = HttpConnector();

                  // Initialize the map
                  Map<String, dynamic> mp = {};

                  mp['subjectCode'] = subjectCodeController.text;
                  mp['subjectName'] = subjectNameController.text;
                  mp['contactHours'] = int.parse(totalHoursController.text);

                  conn.addSubjectToStudent(regno.toString(), mp);
                });

                await _refreshSubjects();
                Navigator.pop(context);
              },
              child: const Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}



