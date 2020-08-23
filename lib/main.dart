import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_guide/bloc/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CounterCubit(), child: CounterView());
  }
}

class CounterView extends StatelessWidget {
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter'),
        ),
        body: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, state) => Text(
              '$state',
              style: textTheme.headline2,
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              key: const Key('counterView_increment_floatingActionButton'),
              onPressed: () => context.bloc<CounterCubit>().increment(),
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 32,
            ),
            FloatingActionButton(
              key: const Key('counterView_decrement_floatingActionButton'),
              onPressed: () => context.bloc<CounterCubit>().decrement(),
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
