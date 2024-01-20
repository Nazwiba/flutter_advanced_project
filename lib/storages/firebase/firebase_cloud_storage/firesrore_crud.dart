import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    home: FirebaseCrud(),
  ));
}

class FirebaseCrud extends StatefulWidget {
  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  var nameCtrl = TextEditingController();
  var emailCtrl = TextEditingController();
  late CollectionReference _userCollection;

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection("users");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Cloud Storage"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(
                labelText: "Name", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(
                labelText: "Email", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                addUser();
              },
              child: const Text("Add User")),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final users = snapshot.data!.docs;
                return Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final userId = user.id;
                          final userName = user["name"];
                          final userEmail = user["email"];
                          return ListTile(
                            title: Text(
                              "$userName",
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              "$userEmail",
                              style: const TextStyle(fontSize: 15),
                            ),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      edituser(userId);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      deleteUser(userId);
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          );
                        }));
              })
        ],
      ),
    );
  }

  Future<void> addUser() async {
    return _userCollection
        .add({"name": nameCtrl.text, "email": emailCtrl.text}).then((value) {
      print("user added successfully");
      nameCtrl.clear();
      emailCtrl.clear();
    }).catchError((error) {
      print("Failed to add User $error");
    });
  }

  Stream<QuerySnapshot> getUser() {
    return _userCollection.snapshots();
  }

  void edituser(var id) {
    showDialog(
        context: context,
        builder: (context) {
          final newnameCtrl = TextEditingController();
          final newemailCtrl = TextEditingController();
          return AlertDialog(
            title: const Text("Update User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newnameCtrl,
                  decoration: const InputDecoration(
                      hintText: "Enter name", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: newemailCtrl,
                  decoration: const InputDecoration(
                      hintText: "Enter Email", border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateUser(id, newnameCtrl.text, newemailCtrl.text)
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("Update User"))
            ],
          );
        });
  }

//update user
  Future<void> updateUser(var id, String newname, String newemail) {
    return _userCollection
        .doc(id)
        .update({"name": newname, "email": newemail}).then((value) {
      print("user update Successfully");
    }).catchError((error) {
      print("User Data Update failed $error");
    });
  }

  Future<void> deleteUser(var id) {
    return _userCollection.doc(id).delete().then((value) {
      print("User deelted succefully");
    }).catchError((error) {
      print("User Data Delete failed $error");
    });
  }
}
