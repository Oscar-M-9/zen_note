// import 'dart:async';

// import 'package:my_notes/models/note_model.dart';
// import 'package:sqflite/sqflite.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';

// class DBNote {
//   static const _dataName = 'My_note';
//   static const _dbVersion = 1;

//   static const table = 'Note';

//   static const columnKey = 'key';
//   static const columnTitle = 'title';
//   static const columnBody = 'body';

//   /* Configuracion de la base de datos */
//   DBNote._();
//   static final DBNote instance = DBNote._();

//   static Database? _database;
//   Future<Database?> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }

//   _initDatabase() async {
//     String path = join(await getDatabasesPath(), _dataName);
//     return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
//   }

//   FutureOr<void> _onCreate(Database db, int version) async {
//     await db.execute('''CREATE TABLE $table(
//       $columnKey INTEGER PRIMARY KEY AUTOINCREMENT,
//       $columnTitle TEXT,
//       $columnBody TEXT)''');
//   }

//   /* List notes */
//   Future<List<Map<String, dynamic>>> listNotes() async {
//     Database? db = await instance.database;
//     return await db!.query(table);
//     //   return List.generate(maps.length, (i) { //create a list of memos
//     //     return Note(
//     //       key: int.parse(maps[i]['key']),
//     //       title: maps[i]['title'],
//     //       body: maps[i]['body']),
//     //     );
//     // });
//   }

//   /* Create note */
//   Future createNote(Note note) async {
//     Database? db = await instance.database;
//     await db!.insert(table, {
//       'key': note.key,
//       'title': note.title,
//       'body': note.body,
//     });
//   }

//   /* Update note */
//   Future updateNote(Note note) async {
//     Database? db = await instance.database;
//     // int key = note.toMap()['key'];
//     await db!.update(
//       table,
//       note.toMap(),
//       where: '$columnKey = ?',
//       whereArgs: [note.key],
//     );
//   }

//   /* Delete note */
//   Future deleteNote(int key) async {
//     Database? db = await instance.database;
//     await db!.delete(
//       table,
//       where: '$columnKey = ?',
//       whereArgs: [key],
//     );
//   }

//   /* Delete all note */
//   Future deleteAllNotes() async {
//     Database? db = await instance.database;
//     await db!.delete(table);
//   }
// }
