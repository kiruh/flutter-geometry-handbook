import 'package:sqflite/sqflite.dart';

import 'package:geometry/models/topic.dart';

class Category {
  static const String TABLE_NAME = "Category";
  static const List<String> COLUMNS = [
    'id',
    'title',
  ];

  int id;
  String title;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Category();

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
  }

  Future<List<Topic>> getTopics(Database db) async {
    TopicProvider categoryProvider = new TopicProvider(db);

    return await categoryProvider.getByCategoryId(this.id);
  }
}

class CategoryProvider {
  Database db;

  CategoryProvider(db) {
    this.db = db;
  }

  Future<Category> insert(Category instance) async {
    instance.id = await db.insert(Category.TABLE_NAME, instance.toMap());
    return instance;
  }

  Future<Category> getById(int id) async {
    List<Map> maps = await db.query(
      Category.TABLE_NAME,
      columns: Category.COLUMNS,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return new Category.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(Category.TABLE_NAME, where: "id = ?", whereArgs: [id]);
  }

  Future<int> update(Category instance) async {
    return await db.update(Category.TABLE_NAME, instance.toMap(),
        where: "id = ?", whereArgs: [instance.id]);
  }

  Future<List<Category>> getAll() async {
    List<Map> maps = await db.query(
      Category.TABLE_NAME,
      columns: Category.COLUMNS,
    );

    return maps.map((data) {
      return new Category.fromMap(data);
    }).toList();
  }
}
