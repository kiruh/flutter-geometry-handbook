import 'package:geometry/models/topic_formula.dart';
import 'package:sqflite/sqflite.dart';

class Topic {
  static const String TABLE_NAME = "Topic";
  static const List<String> COLUMNS = [
    'id',
    'categoryId',
    'title',
    'source',
  ];

  int id;
  int categoryId;
  String title;
  String source;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'categoryId': categoryId,
      'title': title,
      'source': source,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Topic();

  Topic.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['categoryId'];
    title = map['title'];
    source = map['source'];
  }

  Future<List<TopicFormula>> getFomulas(Database db) async {
    TopicFormulaProvider categoryProvider = new TopicFormulaProvider(db);

    return await categoryProvider.getByTopicId(this.id);
  }
}

class TopicProvider {
  Database db;

  TopicProvider(db) {
    this.db = db;
  }

  Future<Topic> insert(Topic instance) async {
    instance.id = await db.insert(Topic.TABLE_NAME, instance.toMap());
    return instance;
  }

  Future<Topic> getById(int id) async {
    List<Map> maps = await db.query(
      Topic.TABLE_NAME,
      columns: Topic.COLUMNS,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return new Topic.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(Topic.TABLE_NAME, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(Topic instance) async {
    return await db.update(Topic.TABLE_NAME, instance.toMap(),
        where: "id = ?", whereArgs: [instance.id]);
  }

  Future<List<Topic>> getAll() async {
    List<Map> maps = await db.query(
      Topic.TABLE_NAME,
      columns: Topic.COLUMNS,
    );

    return maps.map((data) {
      return new Topic.fromMap(data);
    }).toList();
  }

  Future<List<Topic>> getByCategoryId(int categoryId) async {
    List<Map> maps = await db.query(
      Topic.TABLE_NAME,
      columns: Topic.COLUMNS,
      where: "categoryId = ?",
      whereArgs: [categoryId],
    );

    return maps.map((data) {
      return new Topic.fromMap(data);
    }).toList();
  }

  Future<List<Topic>> getOrphanes() async {
    List<Map> maps = await db.query(
      Topic.TABLE_NAME,
      columns: Topic.COLUMNS,
      where: "categoryId IS NULL",
    );

    return maps.map((data) {
      return new Topic.fromMap(data);
    }).toList();
  }
}
