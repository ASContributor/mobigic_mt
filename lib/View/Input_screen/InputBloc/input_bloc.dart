import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  final rowController = TextEditingController();
  final colController = TextEditingController();
  final inputController = TextEditingController();
  final int row = 0;
  final int col = 0;
  final List<String> gridList = [];
  InputBloc() : super(InputInitial()) {
    on<InputEvent>((event, emit) {
      // TODO: implement event handler
    });
    
    on<UpdateElementbyIndexEvent>((event, emit) {
      gridList[event.Index] = event.Value;

      emit(ValueUpdatedState());
    });
  }
}
