import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Counter(),
    );
  }
}

class Counter extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final CounterCubit _cubit = BlocProvider.of<CounterCubit>(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, state) => Text(
              state.toString(),
              style: Counter.timerTextStyle,
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => _cubit.increment(),
              child: Icon(
                Icons.add,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            FloatingActionButton(
              onPressed: () => _cubit.decrement(),
              child: Icon(
                Icons.remove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
