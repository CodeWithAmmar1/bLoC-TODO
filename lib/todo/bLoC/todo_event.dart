abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class ToggleTodo extends TodoEvent {
  final int index;
  ToggleTodo(this.index);
}

class DeleteTodo extends TodoEvent {
  final int index;
  DeleteTodo(this.index);
}
