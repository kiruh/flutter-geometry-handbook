import 'package:sqflite/sqflite.dart';

class TopicFormula {
  static const String TABLE_NAME = "TopicFormula";
  static const List<String> COLUMNS = [
    'id',
    'topicId',
    'source',
  ];

  int id;
  int topicId;
  String source;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'topicId': topicId,
      'source': source,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  TopicFormula();

  TopicFormula.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    topicId = map['topicId'];
    source = map['source'];
  }
}

class TopicFormulaProvider {
  Database db;

  TopicFormulaProvider(db) {
    this.db = db;
  }

  Future<TopicFormula> insert(TopicFormula instance) async {
    instance.id = await db.insert(TopicFormula.TABLE_NAME, instance.toMap());
    return instance;
  }

  Future<TopicFormula> getById(int id) async {
    List<Map> maps = await db.query(
      TopicFormula.TABLE_NAME,
      columns: TopicFormula.COLUMNS,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return new TopicFormula.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(TopicFormula.TABLE_NAME, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(TopicFormula instance) async {
    return await db.update(TopicFormula.TABLE_NAME, instance.toMap(),
        where: "id = ?", whereArgs: [instance.id]);
  }

  Future<List<TopicFormula>> getAll() async {
    List<Map> maps = await db.query(
      TopicFormula.TABLE_NAME,
      columns: TopicFormula.COLUMNS,
    );

    return maps.map((data) {
      return new TopicFormula.fromMap(data);
    }).toList();
  }

  Future<List<TopicFormula>> getByTopicId(int topicId) async {
    List<Map> maps = await db.query(
      TopicFormula.TABLE_NAME,
      columns: TopicFormula.COLUMNS,
      where: "topicId = ?",
      whereArgs: [topicId],
    );

    return maps.map((data) {
      return new TopicFormula.fromMap(data);
    }).toList();
  }
}
