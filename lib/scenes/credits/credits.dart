import 'package:flutter/material.dart';
import 'package:credits/credits.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.keyboard_return),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Credits(
        pauseOnTouch: false,
        duration: const Duration(seconds: 12),
        delay: const Duration(seconds: 1),
        backgroundColor: Colors.blue,
        curve: Curves.slowMiddle,
        onFinished: () => Navigator.pop(context),
        children: [
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/images/nonna-nera.png',
              fit: BoxFit.fill,
            ),
          ),
          _creditText("Da un'idea di Lucia Soro", 20),
          _creditText("Sviluppato da Claudio Biancalana", 20),
        ],
      ),
    );
  }

  Widget _creditText(String text, double size) => Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Text(
          text,
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      );
}
