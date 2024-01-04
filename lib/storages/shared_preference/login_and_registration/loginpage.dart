import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/shared_preference/login_and_registration/homepage.dart';
import 'package:flutter_advanced_project/storages/shared_preference/login_and_registration/registrationpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginShared(),
  ));
}

class LoginShared extends StatefulWidget {
  @override
  State<LoginShared> createState() => _LoginSharedState();
}

class _LoginSharedState extends State<LoginShared> {
  var formkey = GlobalKey<FormState>();
  var usernameCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  late SharedPreferences preferences;
  late bool newUser;

  @override
  void initState() {
    check_if_user_is_already_Login();
// whenevr we open the app check the user is logged in or not
//so we should create this method inside initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: Center(
          child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
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
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: passwordCtrl,
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return "Password is empty or Password length should be > 6";
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
                  ElevatedButton(
                      onPressed: () {
                        var valid = formkey.currentState!.validate();
                        if (valid == true) {
                          validateInput();
                        }
                      },
                      child: const Text("Login")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterShared()));
                      },
                      child: const Text("Don't Have an Account? Register Here"))
                ],
              )),
        ));
  }

  void validateInput() async {
    String username = usernameCtrl.text;
    String password = passwordCtrl.text;

    preferences = await SharedPreferences.getInstance();

    // if a user is logged in then mark it as not a new user
    preferences.setBool("newUser", false);

    // read the registered value
    String? regUsername = preferences.getString("username");
    String? regPassword = preferences.getString("pwd");

    if (regUsername == username && regPassword == password) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeShared()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Invalid Inputs!!")));
    }
  }

  void check_if_user_is_already_Login() async {
    preferences = await SharedPreferences.getInstance();

    // ?? - if the condition is null second statement  will execute
    // the key newUser create when we only click on login button before that will be null
    newUser = preferences.getBool("newUser") ?? true;

    if (newUser == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeShared()));
    }
  }
}
