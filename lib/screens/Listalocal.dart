import 'dart:convert';
import 'package:flutter/material.dart';

class Listalocal extends StatelessWidget {
  const Listalocal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lista(context),
    );
  }
}

Future<List> leerJson(context) async {
  String jsonString = await DefaultAssetBundle.of(context).loadString("lib/assets/data/video_juegos.json");
  Map datos = json.decode(jsonString);
  return datos["videojuegos"];
}

Widget lista(context) {
  return FutureBuilder(
    future: leerJson(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState== ConnectionState.waiting){
        return CircularProgressIndicator();
      }
      if (snapshot.hasData) {
        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item['titulo']),
            );
          },
        );
      } else {
        return Text("No se encontró datos");
      }
    },
  );
}