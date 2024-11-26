import 'package:flutter/material.dart';
import 'HTTP_Request/Http_connector.dart';

void main() => runApp(const MaterialApp(
      home: MyHome(),
    ));

class MyHome extends StatefulWidget {
  @override
  const MyHome({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<MyHome> {
  HttpConnector conn = new HttpConnector();

  late Map<String, dynamic> temp;

  void func() {
    conn.getStudentByRegNo('123456').then((studentData) {
      temp = studentData;
      print(temp);
    });
    // print(temp);
    Future<Map<String, dynamic>> e = conn.getStudentByRegNo('123456');
    print(e);
  }

  final List<Map<String, dynamic>> subjects = [
    {
      'subjectName': 'Mathematics',
      'year': 2,
      'batch': 1,
      'contactHours': 50,
    },
    {
      'subjectName': 'OO',
      'year': 3,
      'batch': 1,
      'contactHours': 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    func();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: addSub,
        backgroundColor: Colors.blue, // Adjust color as needed
        child: const Icon(Icons.add),
      ),
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
                      builder: (context) => adminDetail(
                          // Pass subject details here
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
                              'Year : ${subject['year']}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Batch : ${subject['batch']}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Total classes : ${subject['contactHours']}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
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
    );
  }

  void addSub() {
    String subjectName = '';
    int year = 1;
    int batch = 1;
    int contactHours = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Subject Name'),
                onChanged: (value) {
                  subjectName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  year = int.tryParse(value) ?? 1;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Batch'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  batch = int.tryParse(value) ?? 1;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Total Classes'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  contactHours = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  subjects.add({
                    'subjectName': subjectName,
                    'year': year,
                    'batch': batch,
                    'contactHours': contactHours,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  adminDetail() {}
}
