import 'package:career_genie_bot/ui/bot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:career_genie_bot/bloc/candidate_bloc.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CandidateBloc(),
      child: MaterialApp(
        title: 'Career Genie',
        home: BotScreen(),
      ),
    );
  }
}
