import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MaterialApp(
    home: Permissionsss(),
  ));
}

class Permissionsss extends StatelessWidget {
  const Permissionsss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  askCameraPermission(context);
                },
                child: const Text("Camera")),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  askMultiPermission();
                },
                child: const Text("Multiple Permission")),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  openAppSettingss();
                },
                child: const Text("Settings"))
          ],
        ),
      ),
    );
  }

  void askCameraPermission(BuildContext context) async {
    var status = await Permission.camera.status;
    if (await Permission.camera.request().isGranted) {
      var picker = ImagePicker();
      picker.pickImage(source: ImageSource.camera);
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Permission Denied")));
    }
  }

  void askMultiPermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.contacts,
      Permission.mediaLibrary,
      Permission.phone,
      Permission.microphone,
      Permission.photos
    ].request();
    print("status location ${status[Permission.location]} photos ${status[Permission.photos]}");
  }

  void openAppSettingss() async {
    await openAppSettings();
  }
}
