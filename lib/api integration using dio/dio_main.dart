import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/dataHome.dart';

void main() {
  runApp(DioMain());
}

class DioMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: DataHomeDio()
    );
  }
}
