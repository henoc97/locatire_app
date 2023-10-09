import 'package:bloc/bloc.dart';

part 'sign_log_state.dart';

class SignLogCubit extends Cubit<int> {
  SignLogCubit() : super(0);
  void increment ()=>emit(state + 1);
}
