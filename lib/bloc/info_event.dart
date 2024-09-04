part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();

  @override
  List<Object> get props => [];
}

class LoadInfo extends InfoEvent {
  final List<PageInfo> moduleinfo;
  final int coursenumber;
  final List<QuizQuestion> questions;

  const LoadInfo({
    required this.moduleinfo,
    required this.coursenumber,
    required this.questions, 
  });

  @override
  List<Object> get props => [moduleinfo, coursenumber, questions];
}

class PlayAudio extends InfoEvent {
  final String audiopath;

  const PlayAudio({required this.audiopath});

  @override
  List<Object> get props => [audiopath];
}

class PageChanged extends InfoEvent {
  final int page;
  final List<PageInfo> moduleinfo;

  const PageChanged({required this.page, required this.moduleinfo});

  @override
  List<Object> get props => [page, moduleinfo];
}
