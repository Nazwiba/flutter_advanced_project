import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sq_registration.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sq_user_home.dart';
import 'package:flutter_advanced_project/storages/sqflite/login%20and%20registration/sqflite_function.dart';

import 'sq_admin_home.dart';

class SqLogin extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void loginUser(String email, String pwd) async {
      // adminlogin
      if (email == "admin@gmail.com" && pwd == "admin123") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      } else {
        // chech if user is exist in db
        var data = await SQL_Functions.checkUserExist(email, pwd);
        if (data.isNotEmpty) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => UserHome(data: data)));
        }
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
                  onPressed: () {
                    var valid = formkey.currentState!.validate();
                    if (valid) {
                      loginUser(emailCtrl.text, passCtrl.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please Verify All fields")));
                    }
                  },
                  child: const Text("Login Now ")),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SqRegistration()));
                  },
                  child: const Text("Register Here"))
            ],
          ),
        ),
      ),
    );
  }
}
