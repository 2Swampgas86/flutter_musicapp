import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:musicapp/bloc/auth_bloc.dart';
import 'package:musicapp/providers/level_provider.dart';
import 'package:musicapp/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musicapp/providers/module_provider.dart';

import 'package:provider/provider.dart';

var kcolorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 220, 184, 3));
var kcolorSchemebutton =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 133, 220));

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAzKPOIskP5oNdZdMQTvNS6FCtuFEm-rvM",
            appId: "1:759636103560:android:8c86b6737971c34421ea3d",
            messagingSenderId: "759636103560",
            projectId: "circleofmusic"));
  } catch (e) {
    return;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ModuleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LevelProvider(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            FirebaseAuth.instance,
            Provider.of<LevelProvider>(context, listen: false)
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorSchemebutton.primaryContainer,
              animationDuration: const Duration(microseconds: 10),
              elevation: 10,
              fixedSize: const Size(300, 50),
              shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.all(10),
            ),
          ),
        ),
        home: const AuthPage(),
      ),
    ),
  );
}
