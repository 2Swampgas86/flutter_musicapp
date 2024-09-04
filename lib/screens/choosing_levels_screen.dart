import 'package:musicapp/models/levels_enum.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/selectmodule_screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseClass extends StatelessWidget {
  const ChooseClass({super.key});

  @override
  Widget build(BuildContext context) {
    final lightColor = Theme.of(context).colorScheme.primary.withOpacity(0.2);

    return Consumer<ModuleProvider>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          body: Container(
            color: lightColor,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Choose your level!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        fontFamily: "FrankRuhlLibre"),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 100),
                    child: Column(
                      children: Level.values
                          .map(
                            (level) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextButton(
                                onPressed: () {
                                  var moduleProvider =
                                      context.read<ModuleProvider>();
                                  moduleProvider
                                      .addmodulestoUser(level)
                                      .then((e) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) => SelectModule(
                                                  moduleList: value.moduleList),
                                            ),
                                          ));
                                },
                                child: Text(level.name.toString()),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
