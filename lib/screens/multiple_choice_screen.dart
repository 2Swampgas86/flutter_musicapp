import 'package:musicapp/bloc_mcq/mcq_bloc.dart';
import 'package:musicapp/bloc_mcq/mcq_event.dart';
import 'package:musicapp/bloc_mcq/mcq_state.dart';
import 'package:musicapp/models/questionformat.dart';
import 'package:musicapp/screenhelper/options_selector.dart';
import 'package:musicapp/screens/mqc_result/mcq_result_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audioplayers/audioplayers.dart';

class McqScreen extends StatelessWidget {
  const McqScreen(
      {super.key, required this.questions, required this.coursenumber});
  final List<QuizQuestion> questions;
  final int coursenumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => McqBloc(questions: questions),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 212, 203, 156),
                Color.fromARGB(255, 168, 152, 99)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<McqBloc, McqState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<McqBloc>(context);
              final question = questions[state.questionPos];
              final AudioPlayer audioPlayer = AudioPlayer();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    "Question ${state.questionPos + 1}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                  const Divider(color: Colors.black),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        question.question,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                  question.audio == null
                      ? const SizedBox(
                          height: 1,
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            await audioPlayer.play(UrlSource(question.audio!));
                          },
                        ),
                    if (question.image != null) 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Image.network(
                        question.image!,
                        width: double.infinity,
                        height: 50.0, 
                        fit: BoxFit.cover, 
                      ),
                    ),
                  Expanded(
                    child: ListView(
                      children: question.options.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: state.optionPressed
                              ? Options(
                                  answer: question.correctAnswer,
                                  item: item,
                                  selected: state.answerSelected,
                                )
                              : GestureDetector(
                                  onDoubleTap: () =>
                                      bloc.add(OptionSelected(item)),
                                  child: Options(
                                    answer: question.correctAnswer,
                                    item: item,
                                    selected: state.answerSelected,
                                  ),
                                ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RawMaterialButton(
                        onPressed: state.optionPressed
                            ? () {
                                if (state.questionPos == 4) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => McqResultPage(
                                        coursenumber: coursenumber,
                                        resultList: state.wrongAnswerList,
                                        score: state.score,
                                      ),
                                    ),
                                  );
                                } else {
                                  bloc.add(NextQuestion());
                                }
                              }
                            : null,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(18.0),
                        elevation: 0.0,
                        child: Text(
                          state.btnText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
