import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbConnector {
  static Database db;

  static Future<Database> getDatabase() async {
    if (db == null) {
      db = await initDb();
    }
    return db;
  }
}

Future<Database> initDb() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'todos.db');

  var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  return db;
}

void _onCreate(Database db, int newVersion) async {
  await db.execute(
    '''
    CREATE TABLE Category ( 
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      title TEXT NOT NULL,
      hasChildren INTEGER NOT NULL,
      parentId INTEGER,
      FOREIGN KEY (parentId) REFERENCES Category(id)
    );

    CREATE TABLE Topic (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      source TEXT
    );

    CREATE TABLE TopicFomula (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      topicId INTEGER NOT NULL,
      source TEXT,
      FOREIGN KEY (topicId) REFERENCES Topic(id)
    );
    ''',
  );
}
