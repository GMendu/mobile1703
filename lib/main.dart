import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(Inicializacao);
  runApp(const MyApp());
}

Future Inicializacao(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 5));
}

String imageLink = 'assets/cara.png';
enum Chances { cara, coroa, lado }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cara ou coroa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var rng = Random();
  Chances? _escolha = Chances.cara;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;

  @override
  void initState() {
    super.initState();
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 1));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  int random() {
    _counter = rng.nextInt(6001);
    if (_counter < 100) {
      return 3;
    } else if (_counter > 3000) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Container(
              width: 200,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Cara'),
                    leading: Radio<Chances>(
                      value: Chances.cara,
                      groupValue: _escolha,
                      onChanged: (Chances? value) {
                        setState(() {
                          _escolha = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Coroa'),
                    leading: Radio<Chances>(
                      value: Chances.coroa,
                      groupValue: _escolha,
                      onChanged: (Chances? value) {
                        setState(() {
                          _escolha = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Lado'),
                    leading: Radio<Chances>(
                      value: Chances.lado,
                      groupValue: _escolha,
                      onChanged: (Chances? value) {
                        setState(() {
                          _escolha = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              // Change button text when light changes state.
              child: Image.asset(
                imageLink,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                blastDirection: pi, // radial value - LEFT
                particleDrag: 0.05, // apply drag to the confetti
                emissionFrequency: 0.05, // how often it should emit
                numberOfParticles: 20, // number of particles to emit
                gravity: 0.05, // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink
                ], // manually specify the colors to be used
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ConfettiWidget(
                confettiController: _controllerCenterLeft,
                blastDirection: 0, // radial value - RIGHT
                emissionFrequency: 0.6,
                minimumSize: const Size(10,
                    10), // set the minimum potential size for the confetti (width, height)
                maximumSize: const Size(50,
                    50), // set the maximum potential size for the confetti (width, height)
                numberOfParticles: 1,
                gravity: 0.1,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          int moeda = random();
          if (moeda == 1) {
            imageLink = "assets/cara.png";
            if (_escolha == Chances.cara) {
              _controllerCenterRight.play();
              _controllerCenterLeft.play();
            }
          } else if (moeda == 2) {
            imageLink = "assets/coroa.png";
            if (_escolha == Chances.coroa) {
              _controllerCenterRight.play();
              _controllerCenterLeft.play();
            }
          }
          if (moeda == 3) {
            imageLink = "assets/ladinho.png";
            if (_escolha == Chances.lado) {
              _controllerCenterRight.play();
              _controllerCenterLeft.play();
            }
          }
        }),
        tooltip: 'Girar',
        child: const Icon(
          Icons.flip_camera_android_sharp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
