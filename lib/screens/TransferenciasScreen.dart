import 'package:evaluacion_2/screens/DepositosScreen.dart';
import 'package:evaluacion_2/screens/Listalocal.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Transferencias extends StatelessWidget {
  const Transferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transferencias")),
      body: formulario(context),
    );
  }
}

Widget formulario(BuildContext context) {
   TextEditingController cuenta = TextEditingController();
   TextEditingController destinario = TextEditingController();
   TextEditingController monto = TextEditingController();
   TextEditingController descripcion = TextEditingController();

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: cuenta,
          decoration: const InputDecoration(labelText: "Número de cuenta"),
        ),
        TextField(
          controller: destinario,
          decoration: const InputDecoration(labelText: "Destinario"),
        ),
        TextField(
          controller: monto,
          decoration: const InputDecoration(labelText: "Monto"),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: descripcion,
          decoration: const InputDecoration(labelText: "Descripción"),
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () {
            guardardatos(
              cuenta.text,
              destinario.text,
              monto.text,
              descripcion.text,
            );
          },
          child: const Text("Guardar"),
        ),
        const SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Listalocal()),
            );
          },
          child: const Text("Ver depósitos"),
        ),
      ],
    ),
  );
}

Future<void> guardardatos(String cuenta, String destinario, String monto, String descripcion) async {
  final supabase = Supabase.instance.client;

  await supabase.from('transferencias').insert({
    'cuenta': cuenta,
    'destinario': destinario,
    'monto': monto,
    'descripcion': descripcion,
  });
}


