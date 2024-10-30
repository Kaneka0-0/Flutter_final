import 'package:flutter/material.dart';
import 'package:final_module/final_module/theme_logic.dart';
import 'package:provider/provider.dart';
import 'music_logic.dart';
import 'first_screen.dart';

Widget musicApp1WithProvider() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MusicLogic()),
      ChangeNotifierProvider(create: (context) => ThemeLogic()),
    ],
    child: const SplashScreen(),
  );
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<void>(
        future: context.read<MusicLogic>().getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const AsyncApp();
          } else {
            return _buildLoading();
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.face, size: 200),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class AsyncApp extends StatelessWidget {
  const AsyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}
