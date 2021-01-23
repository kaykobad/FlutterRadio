import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/bloc/radio_state.dart';

import '../bloc/radio_bloc.dart';
import '../radio_player/audio_player.dart';
import '../radio_player/radio_player.dart';

class FlutterRadio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RadioPlayer radioPlayer = JustAudioPlayer();
    return MaterialApp(
      title: 'Flutter Radio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider<RadioBloc>(
        create: (context) => RadioBloc(PausedState()),
        child: Container(),
      ),
    );
  }
}