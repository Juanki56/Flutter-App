import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controlador para obtener el texto del TextField
  final TextEditingController _nombreController = TextEditingController();

  // Método para mostrar el SnackBar
  void _mostrarSaludo() {
    // Ocultar el teclado si está abierto
    FocusScope.of(context).unfocus();

    final String nombre = _nombreController.text.trim();

    // 1. Validar que el nombre no esté vacío
    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Por favor, ingresa tu nombre.'),
          backgroundColor: Colors.redAccent, // Color para indicar error
        ),
      );
      return; // No continuar si el nombre está vacío
    }

    // 2. Mostrar el SnackBar con un diseño mejorado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Hola, $nombre! Un gusto saludarte.'),
        // 3. SnackBar flotante para un look moderno
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            // La acción puede estar vacía si solo es para cerrar
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Liberar recursos del controlador
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
        backgroundColor: Colors.blue,
      ),
      // Usamos un ListView para mostrar múltiples tarjetas
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          // 1. Mantenemos la tarjeta original para el saludo
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 8.0,
            shadowColor: Colors.blue.withOpacity(0.5),
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Ingresa tu nombre',
                      hintText: 'Escribe aquí...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _mostrarSaludo,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5.0,
                    ),
                    child: const Text('Saludar'),
                  ),
                ],
              ),
            ),
          ),

          // 2. Añadimos nuevas tarjetas de información
          const InfoCard(
            title: 'Noticias del Día',
            icon: Icons.article,
            content: 'Flutter 3.13 ha sido lanzado con nuevas mejoras de rendimiento y funcionalidades para Impeller.',
          ),
          const InfoCard(
            title: 'Próximos Eventos',
            icon: Icons.event,
            content: 'No te pierdas el Flutter Forward el próximo mes. ¡Regístrate ahora para no perderte las novedades!',
          ),
          const InfoCard(
            title: 'Configuración',
            icon: Icons.settings,
            content: 'Personaliza las notificaciones y preferencias de la aplicación en el menú de ajustes.',
          ),
        ],
      ),
    );
  }
}

// WIDGET REUTILIZABLE PARA LAS TARJETAS DE INFORMACIÓN
class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8.0,
      shadowColor: Colors.blue.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
