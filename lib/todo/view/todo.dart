import 'package:app/todo/bLoC/todo_bloc.dart';
import 'package:app/todo/bLoC/todo_event.dart';
import 'package:app/todo/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoApp extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: Text(
          'Simple Todo BLoC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.limeAccent,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Enter a task',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.limeAccent,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.limeAccent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.black),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty) {
                        todoBloc.add(AddTodo(controller.text.trim()));
                        controller.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, List<Todo>>(
              builder:
                  (context, todos) => ListView.builder(
                    itemCount: todos.length,
                    itemBuilder:
                        (context, index) => ListTile(
                          title: Text(
                            todos[index].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration:
                                  todos[index].isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                              decorationColor: Colors.red,
                              decorationThickness: 2.5,
                            ),
                          ),
                          leading: Checkbox(
                            checkColor: Colors.black,
                            activeColor: Colors.limeAccent,
                            value: todos[index].isDone,
                            onChanged: (_) {
                              todoBloc.add(ToggleTodo(index));
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => todoBloc.add(DeleteTodo(index)),
                          ),
                        ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
