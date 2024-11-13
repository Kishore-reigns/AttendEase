import 'package:flutter/material.dart';
import 'detailPage.dart';

void main() => runApp(MaterialApp(
      home: MyHome(),
    ));

class MyHome extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<MyHome> {
  final List<Map<String, dynamic>> subjects = [
    {
      'subjectName': 'Mathematics',
      'year': 2,
      'batch': 1,
      'totalClasses': 50,
    },
    {
      'subjectName': 'OO',
      'year': 3,
      'batch': 1,
      'totalClasses': 45,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => addSub(),
          ),
        ],
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
                      builder: (context) => adminDetail(
                          // Pass subject details here
                          ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Year : ${subject['year']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Batch : ${subject['batch']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Text(
                              'Total classes : ${subject['totalClasses']}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
    int totalClasses = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Subject Name'),
                onChanged: (value) {
                  subjectName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  year = int.tryParse(value) ?? 1;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Batch'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  batch = int.tryParse(value) ?? 1;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Total Classes'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  totalClasses = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  subjects.add({
                    'subjectName': subjectName,
                    'year': year,
                    'batch': batch,
                    'totalClasses': totalClasses,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  adminDetail() {}
}
