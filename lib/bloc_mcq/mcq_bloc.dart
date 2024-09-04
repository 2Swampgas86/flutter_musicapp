import 'package:musicapp/bloc_mcq/mcq_event.dart';
import 'package:musicapp/bloc_mcq/mcq_state.dart';
import 'package:musicapp/models/questionformat.dart';
import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class McqBloc extends Bloc<McqEvent, McqState> {
  final List<QuizQuestion> questions;

  McqBloc({required this.questions})
      : super(const McqState(
          questionPos: 0,
          score: 0,
          wrongAnswerList: [],
          optionPressed: false,
          answerSelected: "",
          btnText: "",
        )) {
    on<OptionSelected>((event, emit) {
      final currentQuestion = questions[state.questionPos];
      final isCorrect = event.selectedOption == currentQuestion.correctAnswer;
      final updatedScore = isCorrect ? state.score + 1 : state.score;
      final updatedWrongAnswerList =
          List<WrongAnswer>.from(state.wrongAnswerList);
      if (!isCorrect) {
        updatedWrongAnswerList.add(WrongAnswer(
          question: currentQuestion.question,
          yourAnswer: event.selectedOption,
          correctAnswer: currentQuestion.correctAnswer,
        ));
      }
      final updatedBtnText =
          state.questionPos == 4 ? "See Results" : "Next Question";
      emit(state.copyWith(
        optionPressed: true,
        answerSelected: event.selectedOption,
        score: updatedScore,
        wrongAnswerList: updatedWrongAnswerList,
        btnText: updatedBtnText,
      ));
    });

    on<NextQuestion>(
      (event, emit) {
        if (state.questionPos == 4) {
          // Navigate to result page, this should be handled in the UI
        } else {
          emit(
            state.copyWith(
              questionPos: state.questionPos + 1,
              optionPressed: false,
              answerSelected: "",
              btnText: "",
            ),
          );
        }
      },
    );
  }
}
