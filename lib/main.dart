import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'configuracion/supabase_config.dart';
import 'pantallas/inicio_pantalla.dart';
import 'pantallas/historial_pantalla.dart';
import 'pantallas/estadisticas_pantalla.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.annoKey, 
  );
  
  runApp(const SistemaPresupuesto());
}

class SistemaPresupuesto extends StatelessWidget {
  const SistemaPresupuesto({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Control de Gastos FES",
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.lexendTextTheme(), 
      ),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _indiceSeleccionado = 0;

  final List<Widget> _pantallas = [
    const InicioPantalla(),
    const HistorialPantalla(),
    const EstadisticasPantalla(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Presupuesto"),
        elevation: 2,
      ),
      body: _pantallas[_indiceSeleccionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSeleccionado,
        onTap: (indice) => setState(() => _indiceSeleccionado = indice),
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Añadir"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Historial"),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Estadísticas"),
        ],
      ),
    );
  }
}