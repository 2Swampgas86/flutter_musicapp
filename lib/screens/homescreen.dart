import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/models/levels_enum.dart';
import 'package:musicapp/providers/module_provider.dart';
import 'package:musicapp/screenhelper/module_tile.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/screens/auth.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> signUserOut(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ModuleProvider>(context, listen: false).clearModuleList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () async {
              await signUserOut(context);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: Level.values.length +
              2, // Two extra for the welcome text and the initial spacing
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox(height: 5);
            } else if (index == 1) {
              return const Column(
                children: [
                  Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      fontFamily: "FrankRuhlLibre",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hope you have a wonderful music session today',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      fontFamily: "FrankRuhlLibre",
                    ),
                  ),
                ],
              );
            } else {
              final level = Level.values[
                  index - 2]; // Adjust index to account for welcome texts
              return ModuleTile(level: level);
            }
          },
        ),
      ),
    );
  }
}
