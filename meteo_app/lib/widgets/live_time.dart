import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LiveTime extends StatefulWidget {
  final DateTime time;
  const LiveTime({
    super.key,
    required this.time,
  });

  @override
  State<LiveTime> createState() => _LiveTimeState();
}

class _LiveTimeState extends State<LiveTime>{
  late DateTime _now;
  late Timer _timer;

  @override
  void initState(){
    super.initState();
    _now = widget.time;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose(){
    _timer.cancel();
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    final localeTime = Localizations.localeOf(context).toString();
    final formatTimeLocale = DateFormat.jm(localeTime).format(_now);
    return Text(
      formatTimeLocale, style: TextStyle(fontSize: 20),
    );
  }
}