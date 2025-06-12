import 'dart:convert';
import 'package:flutter/material.dart';

class Listalocal extends StatelessWidget {
  const Listalocal({super.key});

  Future<List<dynamic>> leerJson(BuildContext context) async {
    try {
      String jsonString = await DefaultAssetBundle.of(context)
          .loadString("assets/data/juegos.json");
      Map<String, dynamic> datos = json.decode(jsonString);
      return datos["videojuegos"] ?? [];
    } catch (e) {
      print("Error al leer JSON: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Videojuegos")),
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
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          juego['titulo'] ?? 'Sin título',
                          style: const TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (juego['imagen'] != null)
                          Center(
                            child: Image.network(
                              juego['imagen'],
                              height: 150,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          "Plataforma: ${juego['plataforma'] is List ? juego['plataforma'].join(', ') : juego['plataforma'] ?? 'N/A'}"
                        ),
                        Text(
                          "Género: ${juego['genero'] is List ? juego['genero'].join(', ') : juego['genero'] ?? 'N/A'}"
                        ),
                        Text("Desarrollador: ${juego['desarrollador'] ?? 'N/A'}"),
                        Text("Precio: \$${juego['precio'] ?? 'N/A'}"),
                        Text("Lanzamiento: ${juego['lanzamiento'] ?? 'N/A'}"),
                        const SizedBox(height: 8),
                        const Text(
                          "Descripción:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(juego['descripcion'] ?? 'Sin descripción'),
                      ],
                    ),
                  ),
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