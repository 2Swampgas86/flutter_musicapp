import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:musicapp/models/page.dart';
import 'package:musicapp/models/questionformat.dart';
import 'package:audioplayers/audioplayers.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
    late final AudioPlayer? player;

  InfoBloc({required this.player}) : super(InfoInitial()) {
    on<LoadInfo>((event, emit) {
      emit(InfoLoaded(
        moduleinfo: event.moduleinfo,
        coursenumber: event.coursenumber,
        questions: event.questions,
      ));
    });

    on<PlayAudio>((event, emit) async {
      await player?.play(AssetSource(event.audiopath));
    });

    on<PageChanged>((event, emit) {
      final isLastPage = event.page == event.moduleinfo.length - 1;
      emit(InfoPageChanged(
        moduleinfo: event.moduleinfo,
        isLastPage: isLastPage,
      ));
    });
  }
}

