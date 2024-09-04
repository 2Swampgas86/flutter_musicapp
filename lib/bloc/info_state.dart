part of 'info_bloc.dart';

abstract class InfoState extends Equatable {
  const InfoState();

  @override
  List<Object> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoaded extends InfoState {
  final List<PageInfo> moduleinfo;
  final int coursenumber;
  final List<QuizQuestion> questions;

  const InfoLoaded({
    required this.moduleinfo,
    required this.coursenumber,
    required this.questions,
  });

  @override
  List<Object> get props => [moduleinfo, coursenumber, questions];
}

class InfoPageChanged extends InfoState {
  final List<PageInfo> moduleinfo;
  final bool isLastPage;

  const InfoPageChanged({
    required this.moduleinfo,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [moduleinfo, isLastPage];
}
