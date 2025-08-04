import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nonnaesterina/model/ricette_model.dart';
import 'package:nonnaesterina/util/util.dart';

class Ricetta extends StatefulWidget {
  const Ricetta({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RicettaState();
  }
}

class _RicettaState extends State<Ricetta> {
  String _configJson = "";

  Widget ingredienti(String ingredienti) {
    return Card(
        elevation: 16, // the size of the shadow
        shadowColor: Colors.black, // shadow color
        color: const Color.fromARGB(255, 191, 207, 172),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(ingredienti,
              softWrap: true, style: const TextStyle(fontSize: 14)),
        ));
  }

  Widget preparazione(String testo) {
    return Card(
        elevation: 16, // the size of the shadow
        shadowColor: Colors.black, // shadow color
        color: const Color.fromARGB(255, 154, 160, 147),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child:
              Text(testo, softWrap: true, style: const TextStyle(fontSize: 14)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    rootBundle.loadString('assets/data/data.json').then((String text) {
      setState(() {
        _configJson = text;
      });
    });

    RicetteModel rm = mapper("", _configJson);

    Column categoriaColumn(IconData icon, String text, String label) {
      Color color = Theme.of(context).primaryColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
                softWrap: true,
              ),
            ),
          ]),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
            softWrap: true,
          )
        ],
      );
    }

    Widget categoria(String difficolta, String tempo) {
      return Center(
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Icon(Icons.food_bank),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(difficolta),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Icon(Icons.timelapse),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tempo),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget titolo = Container(
        child: Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(top: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Descrizione della Ricetta',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: Text(
                    rm.getRicette()[arguments['indice']].descrizione,
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                    softWrap: true,
                  )),
              categoria(
                rm
                    .getRicette()[arguments['indice']]
                    .classificazione
                    .getDifficolta(),
                rm
                    .getRicette()[arguments['indice']]
                    .classificazione
                    .getDurata(),
              ),
            ],
          ),
        )),
      ],
    ));

    Widget img(String location) {
      return Container(
        //width: 400,
        height: 200,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: Image.asset(
              location,
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            rm.getRicette()[arguments['indice']].nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.keyboard_return),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: ListView(
          children: [
            img("assets/images/${rm.getRicette()[arguments['indice']].immagine}"),
            titolo,
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: const Text(
                  "Ingredienti",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ingredienti(rm.getRicette()[arguments['indice']].ingredienti),
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: const Text(
                  "Preparazione",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            preparazione(rm.getRicette()[arguments['indice']].preparazione),
            Container(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: const SizedBox(
                  height: 40,
                ))
          ],
        ),
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: Image.asset(
                        'assets/images/nonna-bianca.png',
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )));
  }
}
