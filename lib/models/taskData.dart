import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:task_manager/key.dart';
import 'package:task_manager/models/task_model.dart';
import "package:http/http.dart" as http;

class TaskData extends ChangeNotifier {
  String _baseURL = "$key.json";

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => [..._tasks.reversed];

  Future<void> addTask(TaskModel task) async {
    final response = await http.post(_baseURL,
        body: json.encode({
          "title": task.title,
          "dateTime": task.dateTime,
          "typeColor": task.typeColor
        }));
    final newTask = TaskModel(
        id: json.decode(response.body)["name"],
        title: task.title,
        dateTime: task.dateTime,
        typeColor: task.typeColor);

    _tasks.add(newTask);
    notifyListeners();
  }

  Future<void> fetchTask() async {
    try {
      final response = await http.get(_baseURL);
      final List<TaskModel> loadedData = [];

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((taskId, taskData) {
        loadedData.add(TaskModel(
            id: taskId,
            title: taskData["title"],
            dateTime: taskData["dateTime"],
            typeColor: taskData["typeColor"]));
      });
      _tasks = loadedData;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> removeTask(String id) async {
    final url = "$key/$id.json";
    final existingProductIndex = _tasks.indexWhere((prod) => prod.id == id);
    var existingProduct = _tasks[existingProductIndex];

    _tasks.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _tasks.insert(existingProductIndex, existingProduct);
      notifyListeners();
    }
    existingProduct = null;
  }
}
