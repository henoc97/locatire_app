part of 'update_picture_bloc.dart';

@immutable
sealed class UpdatePictureState {
  final String pic;
  const UpdatePictureState(this.pic);
}

final class UpdatePictureInitial extends UpdatePictureState {
  const UpdatePictureInitial(super.pic);
}
