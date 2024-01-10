import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sqflite_function.dart';

class UserHome extends StatefulWidget {
  // for passing data
  final data;
  UserHome({super.key, required this.data});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var cemail = TextEditingController();
  var cname = TextEditingController();
  var name, email;

  @override
  void initState() {
    name = widget.data[0]["name"];
    email = widget.data[0]["email"]; // passing data
    //if it is statelesswidget - var name = data[0]["name"];
    // if it is statefullwidget - var name = widget.data[0]["name"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    void editData() {
      setState(() {
        /// setting the current user details to the textfields inside the alert box
        cname.text = name;
        cemail.text = email;
      });

      /// to show a dialogbox
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Edit Data",
                style: TextStyle(fontSize: 25),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: cname,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Name"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: cemail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Edit Email"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          name = cname.text;
                          email = cemail.text;
                        });
                        updateUser();
                        Navigator.of(context).pop();
                        cname.text = "";
                        cemail.text = "";
                      },
                      child: const Text("Update")),
                ],
              ),
              // actions: [
              //   TextButton(onPressed: () {}, child: Text("YES")),
              //   TextButton(onPressed: () {}, child: Text("NO")),
              //   TextButton(onPressed: () {}, child: Text("CANCEL")),
              // ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $name"),
        elevation: 5,
      ),
      body: Card(
        child: ListTile(
          title: Text(
            "$name",
            style: const TextStyle(fontSize: 20),
          ),
          subtitle: Text(
            "$email",
            style: const TextStyle(fontSize: 15),
          ),
          leading: const Icon(Icons.person_outline_outlined),
          trailing: IconButton(
              onPressed: () {
                editData();
              },
              icon: const Icon(Icons.edit)),
        ),
      ),
    );
  }

  void updateUser() async {
    await SQL_Functions.toUpdate(widget.data[0]["id"], name, email);
  }
}
