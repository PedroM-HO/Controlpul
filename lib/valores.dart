class Valores {
  late double min;
  late double max;

  Valores(double min, double max) {
    this.min = min;
    this.max = max;
  }
}

class ConjuntosValores {
  late Valores valoresOptimos;
  late Valores valoresAviso;
  late Valores valoresMal;

  ConjuntosValores(
      Valores valoresOptimos, Valores valoresAviso, Valores valoresMal) {
    this.valoresOptimos = valoresOptimos;
    this.valoresAviso = valoresAviso;
    this.valoresMal = valoresMal;
  }
}

var valoresBromo = ConjuntosValores(Valores(2.0,5.0),Valores(5.1,10),Valores(10,double.infinity));
