import 'package:flutter/material.dart';

import '../modelos/cuenta.dart';
import '../logica/calculadora.dart';
import '../widgets/fila_resultado.dart';

class PantallaCuenta extends StatefulWidget {
  const PantallaCuenta({super.key});

  @override
  State<PantallaCuenta> createState() => _PantallaCuentaState();
}

class _PantallaCuentaState extends State<PantallaCuenta> {
  final TextEditingController montoController =
      TextEditingController();

  Cuenta cuenta = const Cuenta();

  @override
  void dispose() {
    montoController.dispose();
    super.dispose();
  }

  void actualizarMonto(String texto) {
    final double monto = double.tryParse(texto) ?? 0.0;

    setState(() {
      cuenta = cuenta.copyWith(monto: monto);
    });
  }

  void aumentar() {
    setState(() {
      cuenta = aumentarPersonas(cuenta);
    });
  }

  void disminuir() {
    setState(() {
      cuenta = disminuirPersonas(cuenta);
    });
  }

  void actualizarPropina(int? porcentaje) {
    if (porcentaje == null) return;

    setState(() {
      cuenta = cuenta.copyWith(propina: porcentaje);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divisor de cuenta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Calculadora de cuenta de restaurante',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: montoController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: actualizarMonto,
              decoration: const InputDecoration(
                labelText: 'Monto de la cuenta',
                hintText: 'Ejemplo: 150.50',
                prefixText: 'Bs ',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Cantidad de personas',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: disminuir,
                  icon: const Icon(Icons.remove_circle),
                  iconSize: 35,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    '${cuenta.personas}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: aumentar,
                  icon: const Icon(Icons.add_circle),
                  iconSize: 35,
                ),
              ],
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              initialValue: cuenta.propina,
              decoration: const InputDecoration(
                labelText: 'Porcentaje de propina',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('0 %'),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text('10 %'),
                ),
                DropdownMenuItem(
                  value: 15,
                  child: Text('15 %'),
                ),
                DropdownMenuItem(
                  value: 20,
                  child: Text('20 %'),
                ),
              ],
              onChanged: actualizarPropina,
            ),

            const SizedBox(height: 30),

            const Text(
              'Resultados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(),

            FilaResultado(
              etiqueta: 'Propina correspondiente',
              valor: formatearMonto(
                calcularPropina(cuenta),
              ),
            ),

            FilaResultado(
              etiqueta: 'Total con propina',
              valor: formatearMonto(
                calcularTotal(cuenta),
              ),
            ),

            FilaResultado(
              etiqueta: 'Paga cada persona',
              valor: formatearMonto(
                calcularPorPersona(cuenta),
              ),
            ),
          ],
        ),
      ),
    );
  }
}