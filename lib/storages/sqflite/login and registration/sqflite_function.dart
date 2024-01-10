import 'package:sqflite/sqflite.dart' as sql;

class SQL_Functions {
  //create database
  static Future<sql.Database> openOrCreateDb() async {
    return sql.openDatabase("users", version: 1,
        onCreate: (sql.Database db, int version) async {
      await createtable(db);
    });
  }

  //creating table to store user data
  static createtable(sql.Database db) async {
    await db.execute(
        'CREATE TABLE userdata (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)');
  }

// create new user in the table
  static Future<int> addUser(String name, String email, String password) async {
    var db = await SQL_Functions.openOrCreateDb(); // to open database
    var data = {
      "name": name,
      "email": email,
      "password": password
    }; // values inside a qoutes is the column name of the table and it is called keys. here keys are column names values are values from textformfield
    var id = db.insert("userdata", data);
    // Or
    //var id = db.insert({"userdata","name": name,"email": email,"password": password});
    return id;
  }

// check the email and password exist in table
  static Future<List<Map>> checkUserExist(String email, String pwd) async {
    var db = await SQL_Functions.openOrCreateDb(); // to open database
    final data = await db.rawQuery(
        "SELECT * FROM userdata WHERE email = '$email' AND password = '$pwd' ");
    if (data.isEmpty) {
      return data;
    } else {
      return data;
    }
  }

//to check the user is already registered
  static Future<List<Map>> checkUserAlreadyRegister(String email) async {
    var db = await SQL_Functions.openOrCreateDb(); // to open database
    final user =
        await db.rawQuery("SELECT * FROM userdata WHERE email = '$email' ");
    if (user.isNotEmpty) {
      return user;
    } else {
      return user;
    }
  }

// to read all the users form the db
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    var db = await SQL_Functions.openOrCreateDb(); //to open database
    final allusers = await db.rawQuery("SELECT * FROM userdata");
    return allusers;
  }

  // to delete a user
  static Future<void> toDeleteuser(int id) async {
    var db = await SQL_Functions.openOrCreateDb(); // to open database
    db.delete("userdata", where: "id = ?", whereArgs: [id]); // in whereargs = value from the admin page ,here it is id
  }

  static Future<int> toUpdate(int id, String uname, String uemail) async {
    var db = await SQL_Functions.openOrCreateDb();
    final newdata = {"name": uname, "email": uemail};
    final newid = await db.update("userdata", newdata,where: "id = ?", whereArgs: [id]);
    return newid;
  }
}
