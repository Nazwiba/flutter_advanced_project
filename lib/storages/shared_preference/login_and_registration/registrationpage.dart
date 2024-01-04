import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/shared_preference/login_and_registration/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterShared extends StatefulWidget {
  @override
  State<RegisterShared> createState() => _RegisterSharedState();
}

class _RegisterSharedState extends State<RegisterShared> {
  var formkey = GlobalKey<FormState>();
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  var phonenumberCtrl = TextEditingController();
  late SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registration Page"),
        ),
        body: Center(
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: usernameCtrl,
                      validator: (username) {
                        if (username!.isEmpty || !username.contains("@")) {
                          return "Invalid or Empty UserName!!";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email id",
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: passwordCtrl,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "Password is empty Or Password length should be >6";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: phonenumberCtrl,
                      validator: (phonenumber) {
                        if (phonenumber!.isEmpty || phonenumber.length < 10) {
                          return "phonenumber is empty Or phonenumber must be 10";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.phone)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        var valid = formkey.currentState!.validate();
                        if (valid == true) {
                          storeData();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Inputs!!")));
                        }
                      },
                      child: const Text("Register"))
                ],
              )),
        ));
  }

  void storeData() async {
    String email = usernameCtrl.text;
    String password = passwordCtrl.text;
    //int phonenumber = phonenumberCtrl.text as int;
    int phonenumber = int.parse(phonenumberCtrl.text); //convert string

    preferences = await SharedPreferences.getInstance();

    preferences.setString("username", email);
    preferences.setString("pwd", password);
    preferences.setInt("Phone", phonenumber);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginShared()));
  }
}
