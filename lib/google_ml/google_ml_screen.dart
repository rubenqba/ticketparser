import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketparser/bloc/text_detector_bloc.dart';
import 'package:ticketparser/google_ml/google_ml_home.dart';
import 'package:ticketparser/repository/google_ml_text_detector.dart';

class GoogleMLScreen extends StatefulWidget {
  const GoogleMLScreen({super.key});

  @override
  State<GoogleMLScreen> createState() => _GoogleMLScreenState();
}

class _GoogleMLScreenState extends State<GoogleMLScreen> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GoogleMLTextDetector(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Google ML'),
        ),
        body: BlocProvider(
          create: (context) => TextDetectorBloc(
            textDetector: RepositoryProvider.of<GoogleMLTextDetector>(context),
          ),
          child: const GoogleMLHome(),
        ),
      ),
    );
  }
}
