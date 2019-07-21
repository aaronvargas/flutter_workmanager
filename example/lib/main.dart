import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

void main() => runApp(MyApp());

void callbackDispatcher() {
  Workmanager.defaultCallbackDispatcher((echoValue) {
    print("Native echoed: $echoValue");
    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter WorkManager Example"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Initialize the plugin first",
                  style: Theme.of(context).textTheme.headline),
              RaisedButton(
                  child: Text("Start the Flutter background service first"),
                  onPressed: () {
                    Workmanager.initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
                  }),

              Text("One Off Tasks",
                  style: Theme.of(context).textTheme.headline),
              //This job runs once.
              //Most likely this will trigger immediately
              RaisedButton(
                  child: Text("Register OneOff Task"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "1",
                      "simpleTask",
                    );
                  }),
              //This job runs once
              //This wait at least 10 seconds before running
              RaisedButton(
                  child: Text("Register Delayed OneOff Task"),
                  onPressed: () {
                    Workmanager.registerOneOffTask(
                      "2",
                      "simpleDelayedTask",
                      initialDelay: Duration(seconds: 10),
                    );
                  }),

              Text("Periodic Tasks",
                  style: Theme.of(context).textTheme.headline),
              //This job runs periodically
              //It will wait at least 10 seconds before its first launch
              //Since we have not provided a frequency it will be the default 15 minutes
              RaisedButton(
                  child: Text("Register Periodic Task"),
                  onPressed: () {
                    Workmanager.registerPeriodicTask(
                      "3",
                      "simplePeriodicTask",
                      initialDelay: Duration(seconds: 10),
                    );
                  }),
              //This job runs periodically
              //It will run about every hour
              RaisedButton(
                  child: Text("Register 1 hour Periodic Task"),
                  onPressed: () {
                    Workmanager.registerPeriodicTask(
                      "5",
                      "simplePeriodic1HourTask",
                      frequency: Duration(hours: 1),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}