import 'dart:convert';
import 'dart:math';

import 'package:dbsample/app_database.dart';
import 'package:dbsample/post.dart';
import 'package:dbsample/trip.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _postCount = 0;
  int _tripCount = 0;

  @override
  void initState() {
    super.initState();
    AppDatabase.instance.then((value) async {
      await value.postDao.insertOrUpdate(Post(
        1,
        getRandomString(10),
      ));
      await value.tripDao.insertOrUpdate(Trip(1, 1));
      _refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Post count = $_postCount\n Trip count = $_tripCount',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _update,
        tooltip: 'Update',
        child: Icon(Icons.update),
      ),
    );
  }

  void _refresh() {
    print("Refresh");
    AppDatabase.instance.then((value) {
      value.postDao.getAll().then((value) {
        setState(() {
          _postCount = value.length;
        });
      });
      value.tripDao.getAll().then((value) {
        setState(() {
          _tripCount = value.length;
        });
      });
    });
  }

  void _update() {
    print("Update");
    AppDatabase.instance.then((value) async {
      await value.postDao.insertOrUpdate(Post(
        1,
        getRandomString(10),
      ));
      _refresh();
    });
  }

  String getRandomString(int size) {
    final random = Random.secure();
    final values = List<int>.generate(size, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
