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
      appBar: _getAppBar(),
      body: _getBody(),
      bottomSheet: _getBottomSheet(context),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Text(StringConstants.APP_NAME),
      centerTitle: true,
    );
  }

  Container _getBottomSheet(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _getRadioStationImage(),
          _getRadioStationName(),
          _getPlayPauseButton(),
        ],
      ),
    );
  }

  Padding _getPlayPauseButton() {
    return Padding(
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
                BlocProvider.of<RadioBloc>(context).add(PlayEvent(StringConstants.planetRockUrl));
              },
            );
          } else {
            return IconButton(
              icon: Icon(
                Icons.pause,
                size: 32,
              ),
              onPressed: () {
                BlocProvider.of<RadioBloc>(context).add(PauseEvent());
              },
            );
          }
        },
      ),
    );
  }

  Text _getRadioStationName() {
    return Text(
      'Planet Rock',
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Padding _getRadioStationImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 50,
        width: 50,
        child: Image.asset(StringConstants.planetRockImage),
      ),
    );
  }

  Padding _getBody() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Container(
        child: Center(
          child: BlocBuilder<RadioBloc, RadioState>(builder: (context, state) {
            if (state is PausedState) {
              return IdleIndicatorWidget(color: Theme.of(context).accentColor);
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
    );
  }
}
