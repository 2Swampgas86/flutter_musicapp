// ignore: file_names
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screens/homescreen.dart';
import 'package:musicapp/screens/selectmodule_screen1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancedOption extends StatelessWidget {
  const AdvancedOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModuleProvider>(
      builder: (context, value, child) {
        
        return Scaffold(
          backgroundColor:Theme.of(context).colorScheme.primary ,
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(50),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: const Text('Go to the next Level!'),
                      onPressed: () {
                        context.read<ModuleProvider>().unlockNextLevel();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => SelectModule(
                                  moduleList:
                                      context.read<ModuleProvider>().modules),
                            ),
                            (route) => false);
                      }),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: ()  {
                        context.read<ModuleProvider>().unlockNextLevel();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      },
                      child:const Text('Back to Home Screen'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
