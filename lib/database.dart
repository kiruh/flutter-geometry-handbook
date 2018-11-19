import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const Map migrations = {
  1: [
    '''
      CREATE TABLE Category ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL
      );
    ''',
    '''
      CREATE TABLE Topic (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoryId INTEGER,
        title TEXT NOT NULL,
        source TEXT,
        FOREIGN KEY (categoryId) REFERENCES Category(id)
      );
    ''',
    '''
      CREATE TABLE TopicFormula (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        topicId INTEGER NOT NULL,
        source TEXT,
        FOREIGN KEY (topicId) REFERENCES Topic(id)
      );
    '''
  ],
  2: [
    '''
      INSERT INTO Category (id, title) VALUES
      (1, 'Triangle'),
      (2, 'Quadrilateral'),
      (3, 'Prism'),
      (4, 'Pyramid'),
      (5, 'Circle');
    '''
  ],
  3: [
    '''
      INSERT INTO Topic (id, categoryId, title, source) VALUES
      (1, 1, 'Equilateral', 'topic1/index.jpg'),
      (2, 1, 'Right-angled', 'topic2/index.jpg'),
      (3, 1, 'Scalene', 'topic3/index.jpg'),
      (4, 1, 'Isosceles', 'topic4/index.jpg'),

      (5, 2, 'Square', 'topic5/index.jpg'),
      (6, 2, 'Rectangle', 'topic6/index.jpg'),
      (7, 2, 'Rhombus', 'topic7/index.jpg'),
      (8, 2, 'Kite', 'topic8/index.jpg'),
      (9, 2, 'Trapezoid', 'topic9/index.jpg'),
      (10, 2, 'Parallelogram', 'topic10/index.jpg'),

      (11, 3, 'Cube', 'topic11/index.jpg'),
      (12, 3, 'Regular Rectangular', 'topic12/index.jpg'),
      (13, 3, 'Regular Square', 'topic13/index.jpg'),
      (14, 3, 'Regular Triangular', 'topic14/index.jpg'),
      (15, 3, 'Regular Hexagonal', 'topic15/index.jpg'),

      (16, 4, 'Regular Square', 'topic16/index.jpg'),
      (17, 4, 'Regular Triangular', 'topic17/index.jpg'),
      (18, 4, 'Regular Hexagonal', 'topic18/index.jpg'),

      (19, 5, 'Circle', 'topic19/index.jpg'),
      (20, 5, 'Circle Cutout', 'topic20/index.jpg'),
      (21, 5, 'Circle Segment', 'topic21/index.jpg'),
      (22, 5, 'Circle Ring', 'topic22/index.jpg'),

      (23, NULL, 'Hexagon', 'topic23/index.jpg'),
      (24, NULL, 'Cylinder', 'topic24/index.jpg'),
      (25, NULL, 'Cone', 'topic25/index.jpg'),
      (26, NULL, 'Sphere', 'topic26/index.jpg');
    '''
  ],
  4: [
    '''
      INSERT INTO TopicFormula (topicId, source) VALUES
      (1, 'topic1/formula-1.jpg'),
      (1, 'topic1/formula-2.jpg'),
      (1, 'topic1/formula-3.jpg'),
      (1, 'topic1/formula-4.jpg'),
      (1, 'topic1/formula-5.jpg'),
      (1, 'topic1/formula-6.jpg'),

      (2, 'topic2/formula-1.jpg'),
      (2, 'topic2/formula-2.jpg'),
      (2, 'topic2/formula-3.jpg'),
      (2, 'topic2/formula-4.jpg'),
      (2, 'topic2/formula-5.jpg'),

      (3, 'topic3/formula-1.jpg'),
      (3, 'topic3/formula-2.jpg'),

      (4, 'topic4/formula-1.jpg'),
      (4, 'topic4/formula-2.jpg'),
      (4, 'topic4/formula-3.jpg'),

      (5, 'topic5/formula-1.jpg'),
      (5, 'topic5/formula-2.jpg'),
      (5, 'topic5/formula-3.jpg'),

      (6, 'topic6/formula-1.jpg'),
      (6, 'topic6/formula-2.jpg'),
      (6, 'topic6/formula-3.jpg'),
      
      (7, 'topic7/formula-1.jpg'),
      (7, 'topic7/formula-2.jpg'),
      (7, 'topic7/formula-3.jpg'),
      (7, 'topic7/formula-4.jpg'),
      (7, 'topic7/formula-5.jpg'),
      (7, 'topic7/formula-6.jpg'),
    
      (8, 'topic8/formula-1.jpg'),
      (8, 'topic8/formula-2.jpg'),
    
      (9, 'topic9/formula-1.jpg'),
      (9, 'topic9/formula-2.jpg'),
      (9, 'topic9/formula-3.jpg'),
    
      (10, 'topic10/formula-1.jpg'),
      (10, 'topic10/formula-2.jpg'),
    
      (11, 'topic11/formula-1.jpg'),
      (11, 'topic11/formula-2.jpg'),
      (11, 'topic11/formula-3.jpg'),
      (11, 'topic11/formula-4.jpg'),

      (12, 'topic12/formula-1.jpg'),
      (12, 'topic12/formula-2.jpg'),
      (12, 'topic12/formula-3.jpg'),
      (12, 'topic12/formula-4.jpg'),

      (13, 'topic13/formula-1.jpg'),
      (13, 'topic13/formula-2.jpg'),
      (13, 'topic13/formula-3.jpg'),
      (13, 'topic13/formula-4.jpg'),
    
      (14, 'topic14/formula-1.jpg'),
      (14, 'topic14/formula-2.jpg'),
      (14, 'topic14/formula-3.jpg'),
      (14, 'topic14/formula-4.jpg'),
      (14, 'topic14/formula-5.jpg'),
    
      (15, 'topic15/formula-1.jpg'),
      (15, 'topic15/formula-2.jpg'),
      (15, 'topic15/formula-3.jpg'),
      (15, 'topic15/formula-4.jpg'),
      (15, 'topic15/formula-5.jpg'),
      (15, 'topic15/formula-6.jpg'),

      (16, 'topic16/formula-1.jpg'),
      (16, 'topic16/formula-2.jpg'),
      (16, 'topic16/formula-3.jpg'),
      (16, 'topic16/formula-4.jpg'),

      (17, 'topic17/formula-1.jpg'),
      (17, 'topic17/formula-2.jpg'),
      (17, 'topic17/formula-3.jpg'),
      (17, 'topic17/formula-4.jpg'),

      (18, 'topic18/formula-1.jpg'),
      (18, 'topic18/formula-2.jpg'),
      (18, 'topic18/formula-3.jpg'),
      (18, 'topic18/formula-4.jpg'),
      (18, 'topic18/formula-5.jpg'),
      (18, 'topic18/formula-6.jpg'),
      (18, 'topic18/formula-7.jpg'),

      (19, 'topic19/formula-1.jpg'),
      (19, 'topic19/formula-2.jpg'),

      (20, 'topic20/formula-1.jpg'),
      (20, 'topic20/formula-2.jpg'),

      (21, 'topic21/formula-1.jpg'),
      (21, 'topic21/formula-2.jpg'),
      (21, 'topic21/formula-3.jpg'),

      (22, 'topic22/formula-1.jpg'),

      (23, 'topic23/formula-1.jpg'),
      (23, 'topic23/formula-2.jpg'),

      (24, 'topic24/formula-1.jpg'),
      (24, 'topic24/formula-2.jpg'),
      (24, 'topic24/formula-3.jpg'),
      (24, 'topic24/formula-4.jpg'),

      (25, 'topic25/formula-1.jpg'),
      (25, 'topic25/formula-2.jpg'),
      (25, 'topic25/formula-3.jpg'),
      (25, 'topic25/formula-4.jpg'),
      (25, 'topic25/formula-5.jpg'),
      (25, 'topic25/formula-6.jpg'),

      (26, 'topic26/formula-1.jpg'),
      (26, 'topic26/formula-2.jpg');
    '''
  ],
};

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
  String path = join(databasesPath, 'categories.db');

  var db = await openDatabase(path,
      version: 4, onCreate: _onCreate, onUpgrade: _onUpgrade);
  return db;
}

void executeMigrations(Database db, int from, int to) async {
  print('Executing migration from $from to $to');
  for (int i = from; i < to; i++) {
    List<String> mgrts = migrations[i + 1];
    if (mgrts == null) continue;

    mgrts.forEach((migration) async {
      await db.execute(migration);
    });
  }
}

void _onUpgrade(Database db, int oldVersion, int newVersion) async {
  executeMigrations(db, oldVersion, newVersion);
}

void _onCreate(Database db, int newVersion) async {
  executeMigrations(db, 0, newVersion);
}
