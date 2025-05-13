import 'package:app/todo/bLoC/todo_bloc.dart';
import 'package:app/todo/view/todo.dart';
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
      child: MaterialApp(debugShowCheckedModeBanner: false, home: TodoApp()),
    );
  }
}
