class ClassificazioneModel {
  final String _durata;
  final String _tipo;
  final String _difficolta;

  String getDurata() {
    return _durata;
  }

  String getTipo() {
    return _tipo;
  }

  String getDifficolta() {
    return _difficolta;
  }

  ClassificazioneModel(this._durata, this._tipo, this._difficolta);
}
