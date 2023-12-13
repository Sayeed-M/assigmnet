import 'package:flutter/material.dart';
import 'package:flutter_application_4/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF191623),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF191623),
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Mindful Meal Timer'),
      routes: {
        '/timer': (context) => const MyWidget(),
      },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/timer');
          },
          child: const Text('Start'),
        ),
      ),
    );
  }
}
