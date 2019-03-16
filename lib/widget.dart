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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Uptime: ${snap.data.time}'),
                  Text('Current load Avarege: ${snap.data.loadAvg}'),
                  Text('Last 5 minutes Load Average ${snap.data.loadAvg5}'),
                  Text('Last 15 minutes Load Average ${snap.data.loadAvg15}')
                ],
              ),
            );
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
