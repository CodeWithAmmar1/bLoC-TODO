import 'package:app/model/model.dart';
import 'package:app/todo_bloc.dart';
import 'package:app/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (_) => TodoBloc(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoApp()),
  );
  }
}
class TodoApp extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: Text('Simple Todo BLoC',style: TextStyle(fontWeight: FontWeight.bold,),),centerTitle: true,),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: 'Enter a task'),
                  ),
                ),
                Container(
                decoration:BoxDecoration(
                  color: Colors.limeAccent,shape: BoxShape.circle

                ) ,
                  child: IconButton(
                    icon: Icon(Icons.add),
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
              builder: (context, todos) => ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    todos[index].title,
                    style: TextStyle(
                      decoration: todos[index].isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: todos[index].isDone,
                    onChanged: (_) {
                      todoBloc.add(ToggleTodo(index));
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
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