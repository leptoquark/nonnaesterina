import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonnaesterina/model/classificazione_model.dart';
import 'package:nonnaesterina/model/ricetta_model.dart';
import 'package:nonnaesterina/model/ricette_model.dart';

RicetteModel mapper(String filtro, String jsonString) {
  Map<String, dynamic> ricetteMap = jsonDecode(jsonString);
  List<RicettaModel> rmList = [];

  for (int i = 0; i < ricetteMap["ricette"].length; i++) {
    if (filtro == ricetteMap["ricette"][i]['classificazione']["tipo"] ||
        filtro == '') {
      ClassificazioneModel cm = ClassificazioneModel(
          ricetteMap["ricette"][i]['classificazione']["durata"],
          ricetteMap["ricette"][i]['classificazione']["tipo"],
          ricetteMap["ricette"][i]['classificazione']["difficolta"]);

      RicettaModel rm = RicettaModel(
          ricetteMap["ricette"][i]["nome"],
          ricetteMap["ricette"][i]["descrizione"],
          ricetteMap["ricette"][i]["preparazione"],
          ricetteMap["ricette"][i]["ingredienti"],
          ricetteMap["ricette"][i]["immagine"],
          cm,
          i);

      rmList.add(rm);
    }
  }
  RicetteModel ricetteModel = RicetteModel(ricetteMap["nome"], rmList);
  return ricetteModel;
}

Icon getIcon(String tipo) {
  if (tipo == 'primo') {
    return const Icon(Icons.food_bank);
  } else if (tipo == 'secondo') {
    return const Icon(Icons.fastfood);
  } else if (tipo == 'contorno') {
    return const Icon(Icons.star);
  } else if (tipo == 'dolce') {
    return const Icon(Icons.cookie);
  } else {
    return const Icon(Icons.local_drink);
  }
}

Widget imageNet(String url) {
  return CachedNetworkImage(
    width: 40,
    imageUrl: url,
    placeholder: (context, url) => const CircularProgressIndicator(),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
