part of 'mcqresult_bloc.dart';

sealed class McqresultEvent extends Equatable {
  const McqresultEvent();

  @override
  List<Object> get props => [];
}

class LoadMcqResult extends McqresultEvent {
  final List<WrongAnswer> resultList;
  final int score;
  final int coursenumber;

  const LoadMcqResult( this.resultList, this.score, this.coursenumber);

  @override
  List<Object> get props => [resultList, score, coursenumber];
}