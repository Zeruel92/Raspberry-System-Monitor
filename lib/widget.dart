import 'package:flutter/material.dart';

class LoadAvg extends StatefulWidget {
  final Stream uptimeStream;
  LoadAvg({this.uptimeStream});
  @override
  _LoadAvgState createState() => _LoadAvgState(uptimeStream: uptimeStream);
}

class _LoadAvgState extends State<LoadAvg> {
  final Stream uptimeStream;

  _LoadAvgState({this.uptimeStream});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: uptimeStream,
        builder: (context, AsyncSnapshot snap) {
          if (snap.hasData) {
            return Text('Load Avg: ${snap.data.loadAvg}');
          } else
            return Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Searching RaspberryPi in your Local Network.....')
                ],
              ),
            ));
        },
      ),
    );
  }
}
