import 'package:bloc/bloc.dart';
import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:equatable/equatable.dart';

part 'mcqresult_event.dart';
part 'mcqresult_state.dart';

class McqresultBloc extends Bloc<McqresultEvent, McqresultState> {
  McqresultBloc() : super(McqresultInitial()) {
    on<LoadMcqResult>(_onLoadMcqResult);
  }

  void _onLoadMcqResult(LoadMcqResult event, Emitter<McqresultState> emit) {
    emit(McqResultLoaded(event.resultList, event.score, event.coursenumber));
  }
}