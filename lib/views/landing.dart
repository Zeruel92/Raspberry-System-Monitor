import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raspberry_system_monitor/blocs/bloc.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  late double start;
  late double end;
  late bool animation;
  StreamSubscription? streamListener;
  late GlobalKey<ScaffoldState> _scaffoldState;

  @override
  void initState() {
    super.initState();
    start = 0.0;
    end = 1.0;
    animation = true;
    _scaffoldState = GlobalKey<ScaffoldState>();
    streamListener = Bloc.instance.uptime.stream.listen((event) {
      Navigator.pushReplacementNamed(_scaffoldState.currentContext, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: Container(
        child: StreamBuilder(
            stream: Bloc.instance.uptime.stream,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: start, end: end),
                      duration: Duration(seconds: 1),
                      onEnd: () {
                        if (animation) {
                          if (start == 0.0) {
                            if (!snapshot.hasData)
                              setState(() {
                                start = 1.0;
                                end = 0.0;
                              });
                          } else {
                            if (!snapshot.hasData)
                              setState(() {
                                start = 0.0;
                                end = 1.0;
                              });
                          }
                        }
                      },
                      builder: (_, double opacity, __) => Container(
                        child: Hero(
                            tag: 'splash',
                            child: Image.asset('assets/pi4_board_new.png')),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10000.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withOpacity(opacity),
                                blurRadius: 6.0,
                                spreadRadius: 0.0,
                              )
                            ]),
                      ),
                    ),
                  ),
                  Text('Waiting for Raspberrypi in local network')
                ],
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    animation = false;
    streamListener?.cancel();
    streamListener = null;
    super.dispose();
  }
}
