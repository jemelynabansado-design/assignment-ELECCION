import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import 'dart:convert';

class TodoRepository {
  static const _todosKey = 'todos';

  Future<list<todo>&gt; loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString(_todosKey);
    if (todosJson == null) return [];
    
    final List<dynamic> jsonList = json.decode(todosJson);
    return jsonList.map((json) =&gt; Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    )).toList();
  }

  Future<void> saveTodos(List<todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((todo) =&gt; {
      'id': todo.id,
      'title': todo.title,
      'description': todo.description,
      'isCompleted': todo.isCompleted,
      'createdAt': todo.createdAt.toIso8601String(),
    }).toList();
    await prefs.setString(_todosKey, json.encode(jsonList));
  }
}