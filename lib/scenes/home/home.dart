import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nonnaesterina/model/ricette_model.dart';
import 'package:nonnaesterina/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  String _filtro = "";
  String _configJson = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: burger(context),
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Container(
                child: Row(
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
                  /* const Padding(
              padding: EdgeInsets.all(16.0), child: Text("Nonna Esterina")),*/
                ]))),
        body: landingScene(context),
        //body: GetRicette(),
        bottomNavigationBar: footerNav(context));
  }

  Widget footerNav(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: TabBar(
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/chi-siamo');
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/contattaci');
            }
          },
          tabs: const <Widget>[
            Tab(
                icon: Icon(Icons.account_circle, color: Colors.white),
                child: Text("Chi Siamo")),
            Tab(
                icon: Icon(Icons.email, color: Colors.white),
                child: Text("Contattaci")),
          ]),
    );
  }

  Widget landingScene(BuildContext context) {
    rootBundle.loadString('assets/data/data.json').then((String text) {
      setState(() {
        _configJson = text;
      });
    });

    RicetteModel rm = mapper(_filtro, _configJson);

    return Container(
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(height: 15),
            CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 2.5,
                ),
                items: rm
                    .getRicette()
                    .map((item) => Center(
                            child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text((item.nome)),
                            ));
                            Navigator.pushNamed(context, '/ricetta',
                                arguments: {'indice': item.id});
                          },
                          splashColor: Colors.green,
                          child: Container(
                            width: 400,
                            // height: 300,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: Image.asset(
                                  "assets/images/${item.immagine}",
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
                                item.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )))
                    .toList()),
            const SizedBox(height: 8),
            Expanded(child: listaricette()),
          ]),
    );
  }

  Widget burger(context) {
    return Drawer(child: listaFiltro());
  }

  Widget listaFiltro() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: Image.asset("assets/images/nonna-bianca.png").image,
                  ),
                ),
              )
            ])),
        ListTile(
          leading: getIcon('primo'),
          title: const Text('Primi'),
          onTap: () {
            setState(() {
              _filtro = "primo";
              Navigator.of(context).pop();
            });
          },
        ),
        ListTile(
          leading: getIcon('secondo'),
          title: const Text('Secondi'),
          onTap: () {
            setState(() {
              _filtro = "secondo";
              Navigator.of(context).pop();
            });
          },
        ),
        ListTile(
          leading: getIcon('contorno'),
          title: const Text('Contorni'),
          onTap: () {
            setState(() {
              _filtro = "contorno";
              Navigator.of(context).pop();
            });
          },
        ),
        ListTile(
          leading: getIcon('dolce'),
          title: const Text('Dolci'),
          onTap: () {
            setState(() {
              _filtro = "dolce";
              Navigator.of(context).pop();
            });
          },
        ),
        ListTile(
          leading: getIcon('amaro'),
          title: const Text('Amari'),
          onTap: () {
            setState(() {
              _filtro = "amaro";
              Navigator.of(context).pop();
            });
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _filtro = "";
                Navigator.of(context).pop();
              });
            },
            child: const Text('Tutte le ricette'),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          onTap: () async {
            const url = 'https://www.iubenda.com/privacy-policy/18993336';
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url),
                  mode: LaunchMode.externalApplication);
            }
          },
        ),
      ],
    );
  }

  Widget listaricette() {
    rootBundle.loadString('assets/data/data.json').then((String text) {
      setState(() {
        _configJson = text;
      });
    });

    RicetteModel rm = mapper(_filtro, _configJson);

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      scrollDirection: Axis.vertical,
      itemCount: rm.getRicette().length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int i) {
        return Card(
            child: ListTile(
          title: Text(rm.getRicette()[i].nome),
          leading: CircleAvatar(
              backgroundImage:
                  Image.asset('assets/images/${rm.getRicette()[i].immagine}')
                      .image),
          trailing: getIcon(rm.getRicette()[i].classificazione.getTipo()),
          subtitle: Center(
            child: Row(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(Icons.food_bank),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          rm.getRicette()[i].classificazione.getDifficolta()),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Icon(Icons.timelapse),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(rm.getRicette()[i].classificazione.getDurata()),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text((rm.getRicette()[i].nome)),
            ));
            Navigator.pushNamed(context, '/ricetta',
                arguments: {'indice': rm.getRicette()[i].id});
          },
        ));
      },
    );
  }
}
