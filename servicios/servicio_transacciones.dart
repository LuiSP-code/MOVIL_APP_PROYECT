import 'package:supabase_flutter/supabase_flutter.dart';
import '../lib/modelos/transaccion.dart';


class ServicioTransacciones {
  final _supabase = Supabase.instance.client;


  //método para Guardar
  Future<void> guardarGasto(Transaccion transaccion) async {
    try {
      await _supabase.from('Transacciones').insert(transaccion.aMapa());
    } catch (e) {
      throw Exception("Error al guardar: $e");
    }
  }


  // método para historial
  Future<List<Transaccion>> obtenerHistorial() async {
    final respuesta = await _supabase.from('Transacciones').select().order('fecha_registro');
    return respuesta.map((mapa) => Transaccion.desdeMapa(mapa)).toList();
  }


  // método para Eliminar
  Future<void> eliminarGasto(String id) async {
    await _supabase.from('Transacciones').delete().match({'id': id});
  }
}
