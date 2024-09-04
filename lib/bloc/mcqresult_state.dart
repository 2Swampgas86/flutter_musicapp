part of 'mcqresult_bloc.dart';

sealed class McqresultState extends Equatable {
  const McqresultState();
  
  @override
  List<Object> get props => [];
}

final class McqresultInitial extends McqresultState {}

class McqResultLoaded extends McqresultState {
  final List<WrongAnswer> resultList;
  final int score;
  final int coursenumber;

  const McqResultLoaded(this.resultList, this.score, this.coursenumber);

  @override
  List<Object> get props => [resultList, score, coursenumber];
}
