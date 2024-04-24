import 'package:flutter/material.dart';
import 'package:watch/src/flutter_communicator.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    implements WatchCounterFlutterAPI {
  final WatchCounterHostAPI _watchCounterHostAPI = WatchCounterHostAPI();
  int _counter = 0;

  void _incrementCounter() async {
    try {
      setState(() {
        _counter++;
      });
      await _watchCounterHostAPI.increment();
    } catch (e) {
      print('Error: $e');
    }
  }

  void _decrementCounter() async {
    try {
      setState(() {
        _counter--;
      });
      await _watchCounterHostAPI.decrement();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    WatchCounterFlutterAPI.setUp(this);
    _watchCounterHostAPI.setCounter(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  // Listen for the decrement event from the host
  @override
  void decrement() {
    print("Received decrement event from host");
    setState(() {
      _counter--;
    });
  }

  // Listen for the increment event from the host
  @override
  void increment() {
    print("Received increment event from host");
    setState(() {
      _counter++;
    });
  }
}
