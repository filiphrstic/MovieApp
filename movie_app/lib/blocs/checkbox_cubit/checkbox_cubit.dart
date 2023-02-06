import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkbox_state.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  CheckboxCubit() : super(CheckboxState(isChecked: false));

  void changeValue(bool value) {
    emit(state.copyWith(changeState: value));
  }
}
