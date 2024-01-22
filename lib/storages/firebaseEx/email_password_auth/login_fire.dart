import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/storages/firebaseEx/email_password_auth/register_fire.dart';
import 'fire_function.dart';
import 'home_fire.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:"AIzaSyByMetb4ocZ0vI3JzuuGMWZuyJp7FyW5gc",
          appId: "1:54867206801:android:0b540e26ee839d037c9530",
          messagingSenderId: "",
          projectId: "fir-newoperations"));
  User? user = FirebaseAuth.instance.currentUser;
  runApp(MaterialApp(
    home: user == null ? Login_Fire() : Home_Fire(),
  ));
}

class Login_Fire extends StatelessWidget {
  var email_controller = TextEditingController();
  var pass_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        titleTextStyle: const TextStyle(fontSize: 20),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Here!!!",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: email_controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter your email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: pass_controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Password"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  String email = email_controller.text.trim();
                  String pass = pass_controller.text.trim();

                  FireBaseHelper()
                      .loginUser(email: email, pwd: pass)
                      .then((result) {
                    if (result == null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home_Fire()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blue, content: Text(result)));
                    }
                  });
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register_Fire()));
                },
                child: const Text(
                  "Not A User? Register Here!!!",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}