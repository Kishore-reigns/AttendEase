import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile>{

  String name  = "Your Name";
  String registerNumber = "2022503055";
  String img  =  "https://img.lovepik.com/photo/48006/3554.jpg_wh300.jpg";
  final ImagePicker _picker = ImagePicker();

  void _getSessionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve the student's name and register number from SharedPreferences
      name = prefs.getString('name') ?? "Your Name";
      registerNumber = prefs.getString('registerNumber') ?? "00000";
    });
  }
  @override
  void initState(){
    super.initState();
    _getSessionData();
  }
  void _editName(){
    TextEditingController nameController = TextEditingController(text : name);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(

          title: const Text("Edit Name"),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Enter new name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed:(){
                setState((){
                  name = nameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        )
    );
  }
  void _editRegisterNumber(){
    TextEditingController registerController = TextEditingController(text: registerNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Register Number"),
        content: TextField(
          controller: registerController,

          decoration: const InputDecoration(hintText: "Enter new register number"),




        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState((){
                registerNumber = registerController.text;

              });
              Navigator.pop(context);

            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _editProfilePicture() async{
    try{
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight:800,
        maxWidth: 800,
      );
      if(pickedFile != null){
        setState(() {
          img = pickedFile.path;
        });
      }
    }
    catch(e){
      print("Error picking image: $e");
    }

  }
  Future<void> _logout(BuildContext contex) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route)=>false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    img),
              ),
              const SizedBox(height: 20),

              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                registerNumber,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity, // Full width buttons
                height: 60,
                child: ElevatedButton(
                  onPressed: _editProfilePicture,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Edit Profile Picture',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between buttons

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _editName,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Edit Profile Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _editRegisterNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Edit Register Number',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: ()=>_logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'logout',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}