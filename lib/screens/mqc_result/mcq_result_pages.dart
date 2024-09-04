import 'package:musicapp/bloc/mcqresult_bloc.dart';
import 'package:musicapp/models/your_wrong_answers.dart';
import 'package:musicapp/screens/mqc_result/mcq_result_opening.dart';
import 'package:musicapp/screens/mqc_result/mqc_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class McqResultPage extends StatelessWidget {
  const McqResultPage(
      {super.key,
      required this.resultList,
      required this.score,
      required this.coursenumber});
  final List<WrongAnswer> resultList;

  final int coursenumber;

  final int score;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          McqresultBloc()..add(LoadMcqResult(resultList, score, coursenumber)),
      child: Scaffold(
        body: SafeArea(child: McqResultView()),
      ),
    );
  }
}

class McqResultView extends StatelessWidget {
  final PageController _pageController = PageController();

  McqResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 100),
          curve: Curves.fastOutSlowIn,
        );
      },
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          const McqResultOpening(),
          BlocBuilder<McqresultBloc, McqresultState>(
            builder: (context, state) {
              if (state is McqResultLoaded) {
                return Resultmcq(
                    resultList: state.resultList,
                    score: state.score,
                    coursenumber: state.coursenumber);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
