part of 'input_bloc.dart';

@immutable
sealed class InputEvent {}

class InsertEvent extends InputEvent {}

class InsertGridSizeEvent extends InputEvent {
  final int col;
  final int row;

  InsertGridSizeEvent({required this.col, required this.row});
}

class UpdateElementbyIndexEvent extends InputEvent {
  final int Index;
  final String Value;

  UpdateElementbyIndexEvent({required this.Index, required this.Value});
}
