import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../modelos/transaccion.dart';
import '../servicios/servicio_transacciones.dart';

class EstadisticasPantalla extends StatefulWidget {
  const EstadisticasPantalla({super.key});

  @override
  State<EstadisticasPantalla> createState() => _EstadisticasPantallaState();
}

class _EstadisticasPantallaState extends State<EstadisticasPantalla> {
  // Instanciamos el servicio de Luis
  final _servicio = ServicioTransacciones();
  
  Map<String, double> _gastosPorCategoria = {};
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _procesarDatos();
  }

  // Método que extrae, agrupa y suma los datos
  Future<void> _procesarDatos() async {
    try {
      final transacciones = await _servicio.obtenerHistorial();
      Map<String, double> mapaTemporal = {};
      
      for (var item in transacciones) {
        // Si la categoría ya existe, le suma el monto nuevo. Si no, la crea.
        mapaTemporal[item.categoria] = (mapaTemporal[item.categoria] ?? 0) + item.monto;
      }

      setState(() {
        _gastosPorCategoria = mapaTemporal;
        _cargando = false;
      });
    } catch (e) {
      debugPrint("Error al procesar gráficas: $e");
      setState(() => _cargando = false);
    }
  }

    Color _obtenerColor(int index) {
    List<Color> colores = [
      Colors.indigo, Colors.teal, Colors.orange, 
      Colors.pink, Colors.amber, Colors.blueGrey
    ];
    return colores[index % colores.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estadísticas de Gastos"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _gastosPorCategoria.isEmpty
              ? const Center(child: Text("No hay datos para graficar"))
              : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Text(
                        "Distribución de tu presupuesto",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      // Widget de la gráfica de pastel
                      SizedBox(
                        height: 250,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 50,
                            sections: _gastosPorCategoria.entries.map((entrada) {
                              int index = _gastosPorCategoria.keys.toList().indexOf(entrada.key);
                              return PieChartSectionData(
                                color: _obtenerColor(index),
                                value: entrada.value,
                                title: '${entrada.key}\n\$${entrada.value.toStringAsFixed(0)}',
                                radius: 80,
                                titleStyle: const TextStyle(
                                  fontSize: 12, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.white
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}