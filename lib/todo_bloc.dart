import 'package:app/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super([]) {
    on<AddTodo>((event, emit) {
      final newList = List<Todo>.from(state);
      newList.add(Todo(title: event.title));
      emit(newList);
    });

    on<ToggleTodo>((event, emit) {
      final newList = List<Todo>.from(state);
      newList[event.index].isDone = !newList[event.index].isDone;
      emit(newList);
    });

    on<DeleteTodo>((event, emit) {
      final newList = List<Todo>.from(state)..removeAt(event.index);
      emit(newList);
    });
  }
}