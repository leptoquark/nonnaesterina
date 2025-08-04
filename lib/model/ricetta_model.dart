import 'package:nonnaesterina/model/classificazione_model.dart';

class RicettaModel {
  final String _nome;
  final String _descrizione;
  final String _preparazione;
  final String _ingredienti;
  final String _immagine;
  int id;

  final ClassificazioneModel _classificazione;

  RicettaModel(this._nome, this._descrizione, this._preparazione,
      this._ingredienti, this._immagine, this._classificazione, this.id);

  String get nome {
    return _nome;
  }

  String get descrizione {
    return _descrizione;
  }

  String get preparazione {
    return _preparazione;
  }

  String get ingredienti {
    return _ingredienti;
  }

  String get immagine {
    return _immagine;
  }

  ClassificazioneModel get classificazione {
    return _classificazione;
  }
}
