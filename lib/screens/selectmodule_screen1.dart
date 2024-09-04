import 'package:musicapp/models/module.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:musicapp/screenhelper/card_widget.dart';
import 'package:musicapp/screenhelper/tranform.dart';
import 'package:musicapp/screens/homescreen.dart';
import 'package:flutter/material.dart';

class SelectModule extends StatelessWidget {
  const SelectModule({super.key, required this.moduleList});
  final List<Module> moduleList;
   Future<bool> _onWillPop(BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (Route<dynamic> route) => false,
    );
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: TransformerPageView(
          scrollDirection: Axis.vertical,
          curve: Curves.easeInBack,
          transformer: transformers,
          itemCount: moduleList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 100),
              child: moduleList[index].locked
                  ? Stack(
                      children: [
                        CardWidget(
                          coursenumber: moduleList[index].modulenumber,
                        ),
                        Positioned.fill(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(103, 0, 0, 0),
                            ),
                            child: const Icon(
                              Icons.lock,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : CardWidget(
                      coursenumber: moduleList[index].modulenumber,
                    ),
            );
          },
        ),
      ),
    );
  }
}
