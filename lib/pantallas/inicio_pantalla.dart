import 'package:flutter/material.dart';
import '../modelos/transaccion.dart';
import '../servicios/servicio_transacciones.dart';


class InicioPantalla extends StatefulWidget {
  const InicioPantalla({super.key});


  @override
  State<InicioPantalla> createState() => _InicioPantallaState();
}


class _InicioPantallaState extends State<InicioPantalla> {
  DateTime _fechaSeleccionada = DateTime.now();
  final _moduloTitulo = TextEditingController();
  final _moduloMonto = TextEditingController();
  String _categoriaSeleccionada = "Alimentos";
  
  // Instancia del servicio creado por Luis
  final _servicio = ServicioTransacciones();


  Future<void> _guardarGasto() async {
    final titulo = _moduloTitulo.text;
    final monto = double.tryParse(_moduloMonto.text) ?? 0;


    if (titulo.isEmpty || monto <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ingrese todos los campos correctamente"))
      );
      return;
    }


    try {
      // Usamos el Modelo de Datos de Sergio y el Servicio de Luis
      final nuevaTransaccion = Transaccion(
        titulo: titulo,
        monto: monto,
        categoria: _categoriaSeleccionada,
        fecha: _fechaSeleccionada,
      );


      await _servicio.guardarGasto(nuevaTransaccion);


      _moduloTitulo.clear();
      _moduloMonto.clear();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gasto almacenado correctamente")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }


  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.blueAccent),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() => _fechaSeleccionada = picked);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Registrar Gasto"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Detalles de la transacción", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: _moduloTitulo,
                  decoration: InputDecoration(
                    labelText: 'Concepto',
                    hintText: 'Ej: Cena con amigos',
                    prefixIcon: const Icon(Icons.description_outlined, color: Colors.blueAccent),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true, fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Fecha del gasto", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => _seleccionarFecha(context),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${_fechaSeleccionada.day}/${_fechaSeleccionada.month}/${_fechaSeleccionada.year}", style: const TextStyle(fontSize: 16)),
                        const Icon(Icons.calendar_today, color: Colors.blueAccent),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _moduloMonto,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    prefixIcon: const Icon(Icons.attach_money, color: Colors.greenAccent),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    filled: true, fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Categoría", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _categoriaSeleccionada,
                      isExpanded: true,
                      items: ['Alimentos', 'Transporte', 'Ocio', 'Salud', 'Educación', 'Subscripciones', 'Otros']
                          .map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (val) => setState(() => _categoriaSeleccionada = val!),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: _guardarGasto,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("GUARDAR TRANSACCIÓN", style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1.2)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
