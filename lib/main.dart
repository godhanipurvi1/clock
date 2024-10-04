import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
  String _date = DateFormat('d MMMM, yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      _date = DateFormat('d MMMM, yyyy').format(DateTime.now());
    });
    Future.delayed(Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(37, 37, 45, 1),
      // appBar: AppBar(
      //   title: Text('Clock App'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 1.50,
              child: SizedBox(
                width: 300,
                height: 300,
                child: AnalogClockDivider(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _currentTime,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              _date,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalogClockDivider extends StatefulWidget {
  @override
  _AnalogClockDividerState createState() => _AnalogClockDividerState();
}

class _AnalogClockDividerState extends State<AnalogClockDivider> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // Update the clock every second
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour % 12;
    final minute = now.minute;
    final second = now.second;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Clock face
        Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
          ),
        ),
        Transform.rotate(
          angle: second * pi / 30,
          child: Divider(
            color: Colors.red,
            thickness: 1,
            indent: 10,
            endIndent: 150,
          ),
        ),
        // Minute Hand
        Transform.rotate(
          angle: minute * pi / 30,
          child: Divider(
            color: Colors.grey,
            thickness: 2,
            indent: 20,
            endIndent: 150,
          ),
        ),
        // Hour Hand
        Transform.rotate(
          angle: (hour + minute / 60) * pi / 6,
          child: Divider(
            color: Colors.white,
            thickness: 4,
            indent: 60,
            endIndent: 150,
          ),
        ),
      ],
    );
  }
}
