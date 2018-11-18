import 'package:flutter/material.dart';
import 'package:geometry/models/topic.dart';
import 'package:geometry/topic_view.dart';
import 'package:sqflite/sqflite.dart';

import 'package:geometry/database.dart';
import 'package:geometry/models/category.dart';

import './category_view.dart';

class GeometryApp extends StatefulWidget {
  @override
  GeometryAppState createState() => new GeometryAppState();
}

class GeometryAppState extends State<GeometryApp> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  List<Category> _categories = new List<Category>();
  List<Topic> _topics = new List<Topic>();

  _openCategory(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryView(category: category)),
    );
  }

  _openTopic(Topic topic) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TopicView(topic: topic)),
    );
  }

  Iterable<ListTile> _renderCategories() {
    return _categories.map(
      (Category category) {
        return new ListTile(
          title: new Text(
            category.title,
            style: _biggerFont,
          ),
          trailing: new Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _openCategory(category);
          },
        );
      },
    );
  }

  Iterable<ListTile> _renderTopics() {
    return _topics.map(
      (Topic topic) {
        return new ListTile(
          title: new Text(
            topic.title,
            style: _biggerFont,
          ),
          trailing: new Icon(Icons.keyboard_arrow_right),
          onTap: () {
            _openTopic(topic);
          },
        );
      },
    );
  }

  Widget _renderItems() {
    final Iterable<ListTile> tilesCategories = _renderCategories();
    final Iterable<ListTile> tilesTopics = _renderTopics();

    final Iterable<ListTile> tiles = []
      ..addAll(tilesCategories)
      ..addAll(tilesTopics);

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return new ListView(children: divided);
  }

  Widget buildSync(
      BuildContext context, List<Category> categories, List<Topic> topics) {
    _categories = categories;
    _topics = topics;

    return Scaffold(
      appBar: AppBar(
        title: Text('Geometry'),
      ),
      body: _renderItems(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Function builder =
        (BuildContext context, AsyncSnapshot<List<dynamic>> items) {
      if (items.error != null) {
        print(items.error);
        return Scaffold(
          appBar: AppBar(
            title: Text('Something Went Wrong'),
          ),
        );
      }

      if (items.data == null) {
        return new Center(child: new CircularProgressIndicator());
      }

      List<Category> categories = items.data[0] as List<Category>;
      List<Topic> topics = items.data[1] as List<Topic>;

      return buildSync(context, categories, topics);
    };

    Future<List<dynamic>> future = new Future(() async {
      Database db = await DbConnector.getDatabase();

      CategoryProvider categoryProvider = new CategoryProvider(db);
      TopicProvider topicProvider = new TopicProvider(db);

      List<Category> categories = await categoryProvider.getAll();
      List<Topic> topics = await topicProvider.getOrphanes();

      return [categories, topics];
    });

    return new FutureBuilder(
      future: future,
      builder: builder,
    );
  }
}
