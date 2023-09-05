import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

/**
 * 
On the client side, MethodChannel enables sending messages that correspond to method calls.
 On the platform side, MethodChannel on Android ( MethodChannelAndroid ) and FlutterMethodChannel on iOS ( MethodChanneliOS ) enable receiving method calls and sending back a result.
 */
// The method channel is used to create a communication link by creating a specific name fo the channel. it will help's you to communicate between flutter and specific platform
  final channel = const MethodChannel("MASK");

  void _sendDataToAndroid() async {
    setState(() {
      _counter++;
    });
    //   /**
    //    * An implementation of [invokeMethod] that can return typed maps.
    //     Dart generics are reified, meaning that an untyped Map<dynamic, dynamic> cannot masquerade as a Map<K, V>. Since [invokeMethod] can only return dynamic maps, we instead create a new typed map using [Map.cast].
    //    */
    Map? resultMap = await channel.invokeMapMethod(
        // Show Toast is name of the key that we are going to send to android
        'showToast',
        {"message": "DataSend From Flutter To Android"});
    var result = resultMap!['result']!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result),
    ));
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
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendDataToAndroid,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
