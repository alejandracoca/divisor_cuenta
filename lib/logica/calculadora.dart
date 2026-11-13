
import '../modelos/cuenta.dart';

// Calcular la propina.
double calcularPropina(Cuenta cuenta) {
  return cuenta.monto * cuenta.propina / 100;
}

// Calcular el total con propina.
double calcularTotal(Cuenta cuenta) {
  return cuenta.monto + calcularPropina(cuenta);
}

// Calcular el monto por persona.
double calcularPorPersona(Cuenta cuenta) {
  if (cuenta.personas < 1) {
    return 0.0;
  }

  return calcularTotal(cuenta) / cuenta.personas;
}

// Aumentar la cantidad de personas.
Cuenta aumentarPersonas(Cuenta cuenta) {
  return cuenta.copyWith(personas: cuenta.personas + 1);
}

// Disminuir la cantidad de personas.
Cuenta disminuirPersonas(Cuenta cuenta) {
  if (cuenta.personas <= 1) {
    return cuenta;
  }

  return cuenta.copyWith(personas: cuenta.personas - 1);
}

// Formatea el monto en bolivianos.
String formatearMonto(double monto) {
  return 'Bs ${monto.toStringAsFixed(2)}';
}
