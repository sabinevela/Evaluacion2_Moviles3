import 'package:evaluacion_2/screens/TransferenciasScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Depositos extends StatefulWidget {
  const Depositos({super.key});

  @override
  State<Depositos> createState() => _DepositosState();
}

class _DepositosState extends State<Depositos> {
  Future<List> leerSupabase() async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from('transferencias').select();
    return data;
  }

  Future<void> eliminar(String cuenta) async {
    final supabase = Supabase.instance.client;
    await supabase.from('transferencias').delete().eq('cuenta', cuenta);
    setState(() {});
  }

  Future<void> editar(String cuenta, String monto, String descripcion, String destinario) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('transferencias')
        .update({
          'monto': monto,
          'descripcion': descripcion,
          'destinario': destinario,
        })
        .eq('cuenta', cuenta);
    setState(() {});
  }

  void mostrarDialogoEditar(String cuenta, String montoActual, String descripcionActual, String destinarioActual) {
    final montoController = TextEditingController(text: montoActual);
    final descripcionController = TextEditingController(text: descripcionActual);
    final destinarioController = TextEditingController(text: destinarioActual);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar depósito"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: montoController,
              decoration: const InputDecoration(labelText: "Monto"),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(labelText: "Descripción"),
            ),
            TextField(
              controller: destinarioController,
              decoration: const InputDecoration(labelText: "Destinatario"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await editar(
                cuenta,
                montoController.text,
                descripcionController.text,
                destinarioController.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Depósitos")),
      body: FutureBuilder<List>(
        future: leerSupabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar datos"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay depósitos"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return ListTile(
                title: Text("Monto: \$${item['monto']}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Descripción: ${item['descripcion']}"),
                    Text("Destinatario: ${item['destinario']}"),
                    Text("Cuenta: ${item['cuenta']}"),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton(
                      onPressed: () => mostrarDialogoEditar(
                        item['cuenta'].toString(),
                        item['monto'].toString(),
                        item['descripcion'].toString(),
                        item['destinario'].toString(),
                      ),
                      child: const Text("Editar"),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () => eliminar(item['cuenta'].toString()),
                      child: const Text("Eliminar"),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}



