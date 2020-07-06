import 'package:flutter/cupertino.dart';
import 'package:provider_manager_sample/models/todo.dart';

class TodoManager extends ChangeNotifier {
  final List<String> todos = ['Sample 1'];

  addTodo(String todo) {
    todos.add(todo);
    notifyListeners();
  }

  removeTodo(int index) {
    todos.removeAt(index);
    notifyListeners();
  }
}
