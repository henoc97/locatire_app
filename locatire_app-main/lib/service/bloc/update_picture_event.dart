part of 'update_picture_bloc.dart';

@immutable
sealed class UpdatePictureEvent {}

class SetUpdatePictureEvent extends UpdatePictureEvent {
  final String pic;
  SetUpdatePictureEvent(this.pic);
}

class GetUpdatePictureEvent extends UpdatePictureEvent {}
