part of 'input_bloc.dart';

@immutable
sealed class InputState {}

final class InputInitial extends InputState {}

final class ValueUpdatedState extends InputState {}
