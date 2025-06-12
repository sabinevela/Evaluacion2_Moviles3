import 'dart:convert';
import 'package:flutter/material.dart';

class Listalocal extends StatelessWidget {
  const Listalocal({super.key});

  Future<List<dynamic>> leerJson(BuildContext context) async {
    try {
      String jsonString =
          await DefaultAssetBundle.of(context).loadString("assets/data/juegos.json");
      Map<String, dynamic> datos = json.decode(jsonString);
      return datos["videojuegos"] ?? [];
    } catch (e) {
      print("Error al leer JSON: $e");
      return [];
    }
  }

  void mostrarDetalles(BuildContext context, Map<String, dynamic> juego) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(juego['titulo'] ?? 'Sin título'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Plataforma: ${juego['plataforma'] ?? 'N/A'}"),
            Text("Género: ${juego['genero'] ?? 'N/A'}"),
            Text("Desarrollador: ${juego['desarrollador'] ?? 'N/A'}"),
            Text("Precio: \$${juego['precio'] ?? 'N/A'}"),
            Text("Lanzamiento: ${juego['lanzamiento'] ?? 'N/A'}"),
            const SizedBox(height: 10),
            Text(juego['descripcion'] ?? 'Sin descripción'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videojuegos")),
      body: FutureBuilder<List<dynamic>>(
        future: leerJson(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final juego = data[index];
                return ListTile(
                    subtitle:  Image.network(
                          juego['imagen'],
                        
                        ),
                    
                  title: Text(juego['titulo'] ?? 'Sin título'),
                
                  onTap: () => mostrarDetalles(context, juego),
                );
              },
            );
          } else {
            return const Center(child: Text("No se encontraron videojuegos"));
          }
        },
      ),
    );
  }
}
