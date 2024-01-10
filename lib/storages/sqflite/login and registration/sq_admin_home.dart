import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sqflite_function.dart';

class AdminHome extends StatefulWidget {
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<Map<String, dynamic>> users = []; // to store all the registered user
  @override
  void initState() {
    getAllUsers();
    super.initState();
  }
/// read all the users from db and update the list
  void getAllUsers() async {
    var usersFromDb = await SQL_Functions.getAllUsers();
    setState(() {
      users = usersFromDb;
    });
  }
/// delete single user form the list and update the ui
   void deletUser(int id) async {
    await SQL_Functions.toDeleteuser(id);
    getAllUsers(); // to refresh the ui or list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        elevation: 8,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(users[index][
                      "name"]), // these keys are the coolumn names in the table
                  subtitle: Text(users[index]["email"]),
                  leading:CircleAvatar(child: Text("${users[index]["id"]}"),),
                  trailing: IconButton(
                      onPressed: () {
                        deletUser(users[index]["id"]);
                      },
                      icon: Icon(Icons.delete)),
                ),
              )),
    );
  }
}
