part of 'findmusic_bloc.dart';

@immutable
abstract class FindmusicEvent {}

class IsRecording extends FindmusicEvent {
  final bool isRecording;
  IsRecording({required this.isRecording});
}
