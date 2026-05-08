import 'package:flutter/material.dart';

class HistorialPantalla extends StatelessWidget {
  const HistorialPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Historial de Gastos\n(Asignada a Luis)", textAlign: TextAlign.center),
      ),
    );
  }
}