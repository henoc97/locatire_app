import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_picture_event.dart';
part 'update_picture_state.dart';

class UpdatePictureBloc extends Bloc<UpdatePictureEvent, UpdatePictureState> {
  UpdatePictureBloc() : super(const UpdatePictureInitial("7309681")) {
    on<SetUpdatePictureEvent>((event, emit) {
      emit(UpdatePictureInitial(event.pic));
    });
    on<UpdatePictureEvent>((event, emit) {
      emit(state);
    });
  }
}
