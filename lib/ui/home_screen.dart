import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';

import '../bloc/radio_bloc.dart';
import '../bloc/radio_event.dart';
import '../bloc/radio_state.dart';
import '../constants/string_constants.dart';
import 'idle_dots.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.APP_NAME),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
          child: Center(
            child: BlocBuilder<RadioBloc, RadioState>(builder: (context, state) {
              if (state is PausedState) {
                return IdleDots(color: Theme.of(context).accentColor);
              } else if (state is PlayingState) {
                return Loading(
                  indicator: LineScalePulseOutIndicator(),
                  size: 100,
                  color: Theme.of(context).accentColor,
                );
              } else {
                throw Exception('Unknown state of bloc');
              }
            }),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).primaryColor,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset(StringConstants.planetRockImage),
              ),
            ),
            Text(
              'Planet Rock',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<RadioBloc, RadioState>(
                builder: (context, state) {
                  if (state is PausedState) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                        size: 32,
                      ),
                      onPressed: () {
                        context.bloc<RadioBloc>().add(PlayEvent(StringConstants.planetRockUrl));
                      },
                    );
                  } else {
                    return IconButton(
                      icon: Icon(
                        Icons.pause,
                        size: 32,
                      ),
                      onPressed: () {
                        context.bloc<RadioBloc>().add(PauseEvent());
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
