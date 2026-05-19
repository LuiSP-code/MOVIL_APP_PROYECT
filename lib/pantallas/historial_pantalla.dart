import 'package:flutter/material.dart';
import 'package:finantial_app/configuracion/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HistorialPantalla extends StatefulWidget {
  const HistorialPantalla({super.key});

  @override
  State<HistorialPantalla> createState() => _HistorialPantallaState();
}
// VENTANA: HISTORIAL DE GASTOS
class _HistorialPantallaState extends State<HistorialPantalla> {
  final supabase = Supabase.instance.client;

  // ICONOS PARA LAS CATEGORÍAS
  IconData _getIcon(String categoria) {
    switch (categoria) {
      case 'Alimentos':
        return Icons.restaurant;
      case 'Transporte':
        return Icons.directions_bus;
      case 'Ocio':
        return Icons.movie;
      case 'Salud':
        return Icons.medical_services;
      case 'Educación':
        return Icons.school;
      case 'Subscripciones':
        return Icons.subscriptions;
      default:
        return Icons.attach_money;
    }
  }
  // VENTANA PARA EL HISTORIAL DE GASTOS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Gastos")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: supabase.from('Transacciones').select().order('created_at'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final transacciones = snapshot.data!;
          if (transacciones.isEmpty) {
            return const Center(child: Text("No hay gastos registrados"));
          }
          return ListView.builder(
            itemCount: transacciones.length,
            itemBuilder: (context, index) {
              final item = transacciones[index];