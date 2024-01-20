import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/theme_controller.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (conetxt)=> ThemeProvider(),
    child: MyApp1()));
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: Provider.of<ThemeProvider>(context).isDarkTheme
        ? ThemeData.dark()
        : ThemeData.light(),
        //darkTheme: ThemeData.dark(),
    home: AppThemeChanger(),
  );
  }
}

class AppThemeChanger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).switchtTheme();
            },
            child: const Text("Switch Theme")),
      ),
    );
  }
}
