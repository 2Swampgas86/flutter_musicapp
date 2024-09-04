import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:equatable/equatable.dart';

class McqState extends Equatable {
  final int questionPos;
  final int score;
  final List<WrongAnswer> wrongAnswerList;
  final bool optionPressed;
  final String answerSelected;
  final String btnText;

  const McqState({
    required this.questionPos,
    required this.score,
    required this.wrongAnswerList,
    required this.optionPressed,
    required this.answerSelected,
    required this.btnText,
  });

  McqState copyWith({
    int? questionPos,
    int? score,
    List<WrongAnswer>? wrongAnswerList,
    bool? optionPressed,
    String? answerSelected,
    String? btnText,
  }) {
    return McqState(
      questionPos: questionPos ?? this.questionPos,
      score: score ?? this.score,
      wrongAnswerList: wrongAnswerList ?? this.wrongAnswerList,
      optionPressed: optionPressed ?? this.optionPressed,
      answerSelected: answerSelected ?? this.answerSelected,
      btnText: btnText ?? this.btnText,
    );
  }

  @override
  List<Object> get props => [questionPos, score, wrongAnswerList, optionPressed, answerSelected, btnText];
}
