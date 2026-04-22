class Transaccion {
  final String? id;
  final String titulo;
  final double monto;      
  final String categoria;
  final DateTime fecha;

  Transaccion({
    this.id,
    required this.titulo,
    required this.monto,
    required this.categoria,
    required this.fecha,
  });

  Map<String, dynamic> aMapa() {
    return {
      "titulo": titulo,
      "monto": monto,
      "categoria": categoria,
      "fecha_registro": fecha.toIso8601String(),
    };
  }

  factory Transaccion.desdeMapa(Map<String, dynamic> mapa) {
    return Transaccion(
      id: mapa['id']?.toString(), 
      titulo: mapa['titulo'] ?? 'Sin título', 
      monto: double.tryParse(mapa['monto']?.toString() ?? '0') ?? 0.0,
      categoria: mapa['categoria'] ?? 'Otros',
      fecha: mapa['fecha_registro'] != null 
          ? DateTime.parse(mapa['fecha_registro']) 
          : DateTime.now(), // Si no hay fecha, usa la de hoy
    );
  }
}