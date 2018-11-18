import 'package:flutter/material.dart';
import 'package:geometry/models/topic.dart';
import 'package:geometry/topic_view.dart';
import 'package:sqflite/sqflite.dart';

import 'package:geometry/database.dart';
import 'package:geometry/models/category.dart';

class CategoryView extends StatefulWidget {
  final Category category;

  CategoryView({Key key, @required this.category}) : super(key: key);

  @override
  CategoryViewState createState() => new CategoryViewState();
}

class CategoryViewState extends State<CategoryView> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  List<Topic> _topics = new List<Topic>();

  _openTopic(Topic topic) {
    print(topic.id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TopicView(topic: topic)),
    );
  }

  Widget _renderTopics() {
    final Iterable<ListTile> tiles = _topics.map(
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

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return new ListView(children: divided);
  }

  Widget buildSync(BuildContext context, List<Topic> topics) {
    _topics = topics;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: _renderTopics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Function builder =
        (BuildContext context, AsyncSnapshot<List<Topic>> topics) {
      if (topics.error != null) {
        print(topics.error);
        return Scaffold(
          appBar: AppBar(
            title: Text('Something Went Wrong'),
          ),
        );
      }

      if (topics.data == null) {
        return new Center(child: new CircularProgressIndicator());
      }

      return buildSync(context, topics.data);
    };

    Future<List<Topic>> future = new Future(() async {
      Database db = await DbConnector.getDatabase();
      return await widget.category.getTopics(db);
    });

    return new FutureBuilder(
      future: future,
      builder: builder,
    );
  }
}
