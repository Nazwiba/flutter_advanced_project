import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyByMetb4ocZ0vI3JzuuGMWZuyJp7FyW5gc",
          appId: "1:54867206801:android:0b540e26ee839d037c9530",
          messagingSenderId: "",
          projectId: "fir-newoperations",
          storageBucket: "fir-newoperations.appspot.com"));
  runApp(MaterialApp(
    home: FireImgStorage(),
  ));
}

class FireImgStorage extends StatefulWidget {
  @override
  State<FireImgStorage> createState() => _FireImgStorageState();
}

class _FireImgStorageState extends State<FireImgStorage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Store"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () => upload("camera"),
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera")),
                ElevatedButton.icon(
                    onPressed: () => upload("gallery"),
                    icon: const Icon(Icons.photo),
                    label: const Text("Gallery"))
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: loadMedia(),

                  /// images returned from method
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final image = snapshot.data![index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(image["imageurl"]),
                                title: Text(image["uploaded By"]),
                                subtitle: Text(image["time"]),
                                trailing: IconButton(
                                    onPressed: () => deleteMedia(image["path"]),
                                    icon: const Icon(Icons.delete)),
                              ),
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }

  /// load images from firebase
  Future<void> upload(String imageFrom) async {
    final picker = ImagePicker(); // calling instance of imagepicker
    XFile?
        pickedImage; // xfile i sthe path of image that is from any device so it is automatically cretae the particular path of the particular phone

    try {
      pickedImage = await picker.pickImage(
          source:
              imageFrom == "camera" ? ImageSource.camera : ImageSource.gallery);
      final String filename = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        await storage.ref(filename).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              "uploaded By": "Phone Name",
              "time": "${DateTime.now()}"
            }));
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<List<Map<String, dynamic>>> loadMedia() async {
    List<Map<String, dynamic>> images = [];
    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach(allFiles, (singleFile) async {
      final String fileUrl = await singleFile.getDownloadURL();
      final FullMetadata metadata = await singleFile.getMetadata();

      images.add({
        "imageurl": fileUrl,
        "path": singleFile.fullPath,
        "uploaded By": metadata.customMetadata?["uploaded By"] ?? "NoData",
        "time": metadata.customMetadata?["time"] ?? "${metadata.timeCreated}",
      });
    });
    return images;
  }

  Future<void> deleteMedia(String imagePath) async {
    await storage.ref(imagePath).delete();
    setState(() {});
  }
}
