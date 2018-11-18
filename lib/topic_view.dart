import 'package:flutter/material.dart';
import 'package:geometry/models/topic.dart';
import 'package:geometry/models/topic_formula.dart';
import 'package:sqflite/sqflite.dart';

import 'package:geometry/database.dart';

class TopicView extends StatefulWidget {
  final Topic topic;

  TopicView({Key key, @required this.topic}) : super(key: key);

  @override
  TopicViewState createState() => new TopicViewState();
}

class TopicViewState extends State<TopicView> {
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  List<TopicFormula> _formulas = new List<TopicFormula>();

  List<Widget> _renderFormulas() {
    final List<ListTile> tiles = _formulas.map(
      (TopicFormula formula) {
        String img = 'images/' + formula.source;
        return new ListTile(
          title: Image.asset(
            img,
            height: 70.0,
            alignment: Alignment.centerLeft,
            fit: BoxFit.contain,
          ),
        );
      },
    ).toList();

    final List<Widget> divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return tiles;
  }

  Widget _renderTopic() {
    String logo = 'images/' + widget.topic.source;
    return new ListView(
      children: [
        Image.asset(
          logo,
          height: 240.0,
          fit: BoxFit.contain,
        ),
      ]..addAll(
          _renderFormulas(),
        ),
    );
  }

  Widget buildSync(BuildContext context, List<TopicFormula> formulas) {
    _formulas = formulas;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
      ),
      body: _renderTopic(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Function builder =
        (BuildContext context, AsyncSnapshot<List<TopicFormula>> formulas) {
      if (formulas.error != null) {
        print(formulas.error);
        return Scaffold(
          appBar: AppBar(
            title: Text('Something Went Wrong'),
          ),
        );
      }

      if (formulas.data == null) {
        return new Center(child: new CircularProgressIndicator());
      }

      return buildSync(context, formulas.data);
    };

    Future<List<TopicFormula>> future = new Future(() async {
      Database db = await DbConnector.getDatabase();
      return await widget.topic.getFomulas(db);
    });

    return new FutureBuilder(
      future: future,
      builder: builder,
    );
  }
}
