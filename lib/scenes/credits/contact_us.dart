import 'package:flutter/material.dart';

import 'contact_custom.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_return),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: const AssetImage('assets/images/nonna-bianca.png'),
          email: 'claudio.biancalana@gmail.com',
          instagram: "elledilucia__",
          emailText: 'Email',
          companyName: 'Contattaci!',
          image: Image.asset('assets/images/nonna-bianca.png'),
          companyColor: Colors.teal.shade100,
          dividerThickness: 2,
          //tagLine: 'Contattaci',
          taglineColor: Colors.white,
        ),
      ),
    );
  }
}
