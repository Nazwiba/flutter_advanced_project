import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sq_login.dart';

import 'sqflite_function.dart';

class SqRegistration extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void registerUser(String name, String email, String password) async {
      var id = await SQL_Functions.addUser(
          name, email, password); // id that return when we add new users
      print(id);
      if (id != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SqLogin()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Registration Failed")));
      }
    }

    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email Id",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return "Invalid Username or field is empty";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (pass) {
                    if (pass!.isEmpty || pass.length < 6) {
                      return "Password length should be > 6 or field is empty";
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    var valid = formkey.currentState!.validate();
                    if (valid == true) {
                      var users = await SQL_Functions.checkUserAlreadyRegister(
                          emailCtrl.text);
                      if (users.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User Already Registered!!")));
                      } else {
                        registerUser(
                            nameCtrl.text, emailCtrl.text, passCtrl.text);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Verify All the fields")));
                    }
                  },
                  child: const Text("Register Now"))
            ],
          ),
        ),
      ),
    );
  }
}
