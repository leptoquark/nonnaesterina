// ignore: file_names
import 'package:nonnaesterina/model/ricetta_model.dart';

class RicetteModel {
  final String _nome;
  final List<RicettaModel> _ricette;

  String getNome() {
    return _nome;
  }

  List<RicettaModel> getRicette() {
    return _ricette;
  }

  RicetteModel(this._nome, this._ricette);
}
