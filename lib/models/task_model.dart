import 'package:flutter/cupertino.dart';

class TaskModel extends ChangeNotifier {
  final String id;
  final String title;
  final String dateTime;
  final int typeColor;

  TaskModel({this.id, this.title, this.dateTime, this.typeColor});
}
