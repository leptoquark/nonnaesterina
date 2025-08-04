import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nonnaesterina/scenes/credits/contact_us.dart';
import 'package:nonnaesterina/scenes/credits/credits.dart';
import 'package:nonnaesterina/scenes/ricetta/ricetta.dart';
import 'package:nonnaesterina/scenes/splash/splash_screen.dart';
import 'package:nonnaesterina/util/configuration_json.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  String _versione = "";
  String _titolo = "";

  bool debug = true;

  Future<void> _init() async {
    /* lettura dei parametri di configurazione */

    Configuration.readProperty('versione').then((dynamic versione) {
      setState(() {
        _versione = versione;
      });
    });
    Configuration.readProperty('titolo').then((dynamic titolo) {
      setState(() {
        _titolo = titolo;
      });
    });

    Configuration.readProperty('ambiente').then((dynamic ambiente) {
      setState(() {
        if (ambiente == 'ESERCIZIO') debug = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return DefaultTabController(
        length: 2,
        child: GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            '/chi-siamo': (context) => const About(),
            /* '/contattaci': (BuildContext ctx) => AlertDialog(
                  content: Text("VERSIONE: $_versione\nTITOLO: $_titolo"),
                  //content: Expanded(child: const Text("TESTO")),
                ),*/
            '/contattaci': (context) => const Contact(),
            '/ricetta': (context) => const Ricetta(),
          },
          debugShowCheckedModeBanner: debug,
          home: SplashScreen(),
        ));
  }
}
