import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
    home: DateSelection(),
  ));
}

class DateSelection extends StatefulWidget {

  @override
  State<DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime currentDate = DateTime.now(); // to get current date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: TextField(
          controller: TextEditingController(
              text: "${currentDate.toLocal()}".split(" ")[0]),
          onTap: () => selectDate(context),
          readOnly: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
              labelText: "Select Date", suffixIcon: Icon(Icons.calendar_month)),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }
}
