import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Depositos extends StatefulWidget {
  const Depositos({super.key});

  @override
  State<Depositos> createState() => _DepositosState();
}

class _DepositosState extends State<Depositos> {
  Future<List<dynamic>> cargarVideojuegosLocales() async {
    final String respuesta = await rootBundle.loadString('assets/data/juegos.json');
    final datos = json.decode(respuesta);
    return datos['videojuegos'] ?? [];
  }

  void mostrarDetallesTransaccion(Map<String, dynamic> item) {
    String plataformas = (item['plataforma'] as List<dynamic>?)?.join(', ') ?? 'N/A';
    String generos = (item['genero'] as List<dynamic>?)?.join(', ') ?? 'N/A';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item['titulo'] ?? 'Sin título'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Precio: \$${item['precio'] ?? 'N/A'}"),
              Text("Plataformas: $plataformas"),
              Text("Géneros: $generos"),
              const SizedBox(height: 10),
              Text("Descripción: ${item['descripcion'] ?? 'Sin descripción'}"),
            ],
          ),
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
        future: cargarVideojuegosLocales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay datos disponibles"));
          }

          final juegos = snapshot.data!;
          return ListView.builder(
            itemCount: juegos.length,
            itemBuilder: (context, index) {
              final item = juegos[index];
              final imagenUrl = item['imagen'] ?? '';
              final titulo = item['titulo'] ?? 'Sin título';
              final precio = item['precio']?.toString() ?? 'N/A';
              final plataforma = (item['plataforma'] as List<dynamic>?)?.join(', ') ?? 'N/A';

              return ListTile(
                onTap: () => mostrarDetallesTransaccion(item),
                leading: imagenUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imagenUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image, size: 60);
                          },
                        ),
                      )
                    : const Icon(Icons.videogame_asset, size: 60),
                title: Text(titulo),
                subtitle: Text("Plataformas: $plataforma\nPrecio: \$$precio"),
              );
            },
          );
        },
      ),
    );
  }
}



