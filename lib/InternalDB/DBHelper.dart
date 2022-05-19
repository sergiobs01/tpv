import 'package:sqflite_common/sqlite_api.dart';

import 'Login.dart';

class DBHelper {
 // var databaseFactory = databaseFactoryFfi;
  Database db;

  createDatabase() async {
    // Init ffi loader if needed.
   // sqfliteFfiInit();
   // db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await db.execute('''
          CREATE TABLE Login(
              usuario TEXT PRIMARY KEY,
              contrasena TEXT
          )
        ''');

    await db.execute('''
          CREATE TABLE Configuracion(
              usuario TEXT NOT NULL,
              mesas_disp INTEGER NOT NULL
          )
        ''');
  }

  saveLogin(Login l) async {
    await db.insert('Login', <String, dynamic>{
      'usuario': l.usuario,
      'contrasena': l.contrasena,
    });
  }

  Future<List<Login>> getLogin() async{
    final List<Map<String, dynamic>> login = await db.query('Login');
    return List.generate(login.length, (i) {
      return Login(
        usuario: login[i]['usuario'],
        contrasena: login[i]['contrasena'],
      );
    });
  }
}
