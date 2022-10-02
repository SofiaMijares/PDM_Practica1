import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

part 'findmusic_event.dart';
part 'findmusic_state.dart';
final record = Record();

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
        
        var request = http.MultipartRequest('POST', Uri.parse('https://api.audd.io/'));
        request.fields['api_token'] = '93e9fc0f6dffe5c83f5b6275aa525ad3';
        request.fields['return'] = 'apple_music,spotify';
        String last = filename!.split("/").last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            filename,
            filename: last,
          ),
        );
        var res = await request.send();
        print(res);

        
      }
    });
  }
}
