import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musicfindapp/API/music_api.dart';
import 'package:record/record.dart';


part 'findmusic_event.dart';
part 'findmusic_state.dart';
final record = Record();
final api = APIRepository();

class FindmusicBloc extends Bloc<FindmusicEvent, FindmusicState> {
  FindmusicBloc() : super(FindmusicInitial()) {
    on<IsRecording>((event, emit) async{
      emit(FindmusicRecording(event.isRecording));
      // Check and request permission
      if(event.isRecording){

        if (await record.hasPermission()) {
          // Start recording
          await record.start(
            encoder: AudioEncoder.aacLc, // by default
            bitRate: 128000, // by default
            samplingRate: 44100, // by default
          );
        }
      }else{

        // Stop recording
        final filename = await record.stop();
        //print(filename);
        final res = await api.findSong(filename!);
        print(res);
        
        

        
      }
    });
    // on<AddFavorite>((event, emit) {
    //   final found = state.favorites.firstWhere((element) => element['title'] == event.title && element['artist'] == event.artist, orElse: () => null);
    //   if(found){
    //    return emit(FindMusicFavoritesError(errorMessage: 'La canción ya está en favoritos'));
    //   }
    //   final favoriteMusic = [state.favorites,]
    // });
  }
}
