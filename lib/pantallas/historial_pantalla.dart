import 'package:flutter/material.dart';
import 'package:finantial_app/configuracion/supabase_config.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}
// VENTANA: HISTORIAL DE GASTOS
class _ListScreenState extends State<ListScreen> {
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