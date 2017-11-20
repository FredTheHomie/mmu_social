import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

typedef Future<List<T>> PageRequest<T> (int page, int pageSize);
typedef Future<List<Map>> ApiPageRequest(int page, int pageSize);
typedef void PaginationThresholdCallback();
typedef Widget WidgetAdapter<T>(T t);
typedef int Indexer<T>(T t);

class loadingData<T> extends StatefulWidget {

  /*final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance;

  Future<Map<String, dynamic>> getObject(String category, String id) async {
    DataSnapshot snap = await ref.reference().child('users/$id').once();
    return snap.value;
  }*/
  final PageRequest<T> pageRequest;
  final WidgetAdapter<T> widgetAdapter;
  final int pageSize;
  final int pageThreshold;
  final bool reverse;

  final Indexer<T> indexer;

  loadingData(this.pageRequest, {
    this.pageSize: 50,
    this.pageThreshold: 10,
    @required this.widgetAdapter,
    this.reverse: false,
    this.indexer
  });

  @override
  _loadingDataState createState() => new _loadingDataState();
}

class _loadingDataState<T> extends State<loadingData<T>> {
  List<T> objects = [];

  @override
  Widget build(BuildContext context) {
    ListView listView = new ListView.builder(
      itemBuilder: itemBuilder,
      itemCount: objects.length,
      reverse: widget.reverse,
    );
    return listView;
  }
  Widget itemBuilder(BuildContext context, int index) {
    return widget.widgetAdapter != null ? widget.widgetAdapter(objects[index])
        : new Container();
  }
}