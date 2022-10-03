part of 'findmusic_bloc.dart';

@immutable
abstract class FindmusicEvent {}

class IsRecording extends FindmusicEvent {
  final bool isRecording;
  IsRecording({required this.isRecording});
}

class AddFavorite extends FindmusicEvent {
  final String title;
  final String artist;
  AddFavorite({required this.title, required this.artist});
}