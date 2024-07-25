import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suggest_system_state.dart';

class SuggestSystemCubit extends Cubit<SuggestSystemState> {
  SuggestSystemCubit() : super(SuggestSystemInitial());
}
