import 'package:flutter/material.dart';

class InicioPantalla extends StatelessWidget {
  const InicioPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Pantalla de Formulario\n(Asignada a Víctor)", textAlign: TextAlign.center),
      ),
    );
  }
}