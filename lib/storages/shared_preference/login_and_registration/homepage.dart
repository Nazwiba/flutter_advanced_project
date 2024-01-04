import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/shared_preference/login_and_registration/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeShared extends StatefulWidget {
  @override
  State<HomeShared> createState() => _HomeSharedState();
}

class _HomeSharedState extends State<HomeShared> {
  late SharedPreferences preferences;
  String? username;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                preferences.setBool("newUser", true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginShared()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const CircleAvatar(
              backgroundColor: Colors.blue,
              minRadius: 30,
              child: Icon(Icons.person,size: 35,),),
            Text("Welcome $username!!"),
          ],
        ),
      ),
    );
  }
}
