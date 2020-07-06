import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_manager_sample/managers/todo_manager.dart';

import 'models/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoManager(),
      child: MaterialApp(
        title: 'Provider Manager Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodosPage(),
      ),
    );
  }
}

class TodosPage extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My todo\'s'),
        ),
        body: TodosList(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('Add todo'),
                        content: TextFormField(
                          controller: _controller,
                        ),
                        actions: [
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {},
                          ),
                          RaisedButton(
                              child: Text('Add'),
                              onPressed: () {
                                Provider.of<TodoManager>(context, listen: false)
                                    .addTodo(_controller.text);
                                _controller.text = '';
                                Navigator.pop(context);
                              })
                        ],
                      ));
            }));
  }
}

class TodosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoManager>(
        builder: (_, todoManager, context) => ListView(
              children: todoManager.todos
                  .asMap()
                  .entries
                  .map((entry) => ListTile(
                        title: Text(entry.value),
                        trailing: IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            todoManager.removeTodo(entry.key);
                          },
                        ),
                      ))
                  .toList(),
            ));
  }
}
