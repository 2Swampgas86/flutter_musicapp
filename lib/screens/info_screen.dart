import 'package:musicapp/bloc/info_bloc.dart';
import 'package:musicapp/screens/multiple_choice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/models/page.dart';
import 'package:musicapp/models/questionformat.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoScreen extends StatelessWidget {
  final List<PageInfo> moduleInfo;
  final int courseNumber;
  final List<QuizQuestion> questions;

  const InfoScreen(
      {super.key,
      required this.moduleInfo,
      required this.courseNumber,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoBloc(player: null)
        ..add(LoadInfo(
          questions: questions,
          moduleinfo: moduleInfo,
          coursenumber: courseNumber,
        )),
      child: const InfoView(),
    );
  }
}

class InfoView extends StatefulWidget {
  const InfoView({super.key});

  @override
  InfoViewState createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  PageController? _controller;
  bool _endButton = false;
  var player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if (state is InfoLoaded) {
            final pageList = state.moduleinfo;
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 216, 206, 227),
                    Color.fromARGB(255, 118, 125, 188)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: pageList.length,
                    controller: _controller,
                    onPageChanged: (page) {
                      setState(
                        () {
                          page == pageList.length - 1
                              ? _endButton = true
                              : _endButton = false;
                        },
                      );
                    },
                    itemBuilder: (context, index) {
                      final subtitles = pageList[index].subtitle;
                      final images = pageList[index].image;
                      final audios = pageList[index].audiopath;
                      final userhint = pageList[index].userhint;

                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 5),
                                pageList[index].title == null
                                    ? const SizedBox(height: 5)
                                    : Text(
                                        pageList[index].title!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: subtitles
                                      .map(
                                        (item) => Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                if (images.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    // child:
                                    child: SizedBox(
                                      width: 200,
                                      height: 200, // Adjust height as needed
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: images.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxHeight:
                                                      100, // Adjust maxHeight as needed
                                                  maxWidth:
                                                      100), // Adjust maxWidth as needed
                                              child: Image.network(
                                                images[index],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                if (audios != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: audios
                                          .map(
                                            (item) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    backgroundColor: const Color
                                                        .fromARGB(255, 49, 189,
                                                        236), // Blue background color
                                                    fixedSize: const Size(
                                                        100, 50), // Fixed size
                                                    shape: const StadiumBorder(
                                                      side: BorderSide(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    textStyle: const TextStyle(
                                                      fontSize:
                                                          16, // Adjust font size as needed
                                                    ),
                                                  ),
                                                  child: const Text('Play'),
                                                  onPressed: () async {
                                                    await player
                                                        .play(UrlSource(item));
                                                  },
                                                )),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                userhint != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              openDialog(userhint);
                                            },
                                            child: const Text(
                                              'Hint!!',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(height: 5)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: 25,
                    right: 25,
                    child: _endButton
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor:
                                  const Color.fromARGB(255, 49, 189, 236),
                              animationDuration:
                                  const Duration(milliseconds: 2),
                              elevation: 5,
                              textStyle: const TextStyle(fontSize: 20),
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => McqScreen(
                                      questions: state.questions,
                                      coursenumber: state.coursenumber),
                                ),
                              );
                            },
                            child: const Text('Take Quiz'),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.bottomCenter,
                            child: SmoothPageIndicator(
                              controller: _controller!,
                              count: pageList.length,
                              effect: const WormEffect(
                                activeDotColor: Color.fromARGB(31, 75, 4, 108),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<void> openDialog(String userhint) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Hint!"),
              content: Text(userhint),
            ));
  }
}
