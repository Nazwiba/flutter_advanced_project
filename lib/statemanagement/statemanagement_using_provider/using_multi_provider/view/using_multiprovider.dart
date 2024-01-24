import 'package:flutter/material.dart';
import 'package:flutter_advanced_project/statemanagement/statemanagement_using_provider/using_multi_provider/provider/auth_provider.dart';
import 'package:flutter_advanced_project/statemanagement/statemanagement_using_provider/using_multi_provider/provider/counter_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Count_provider()),
        ChangeNotifierProvider(create: (context) => Auth_provider()),
      ],
      child: MultiProviderr(),
    ),
  ));
}

class MultiProviderr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Counter Value",
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<Count_provider>(context, listen: false)
                      .increment();
                },
                child: const Text("Increment Counter")),
            Text("Count Value : ${Provider.of<Count_provider>(context).count}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Auth Details",
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<Auth_provider>(context,listen: false).login
                      ? Provider.of<Auth_provider>(context,listen: false).logedOut()
                      : Provider.of<Auth_provider>(context,listen: false).logedin();
                },
                child: const Text("Switch Login")),
            Consumer<Auth_provider>(builder: (context, authprovider, child) {
              return Text(
                  "User is ${authprovider.login ? "Logged In" : "Logged Out"}");
            })
          ],
        ),
      ),
    );
  }
}
