import 'package:evaluacion_2/screens/TransferenciasScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Evaluación")),
      body: formularioLogin(context),
    );
  }
}

Widget formularioLogin(context) {
  TextEditingController _correo = TextEditingController();
  TextEditingController _contrasenia = TextEditingController();

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("LOGIN", style: TextStyle(fontSize: 40)),
        TextField(
          controller: _correo,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Correo"),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _contrasenia,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Contraseña"),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => login(_correo.text, _contrasenia.text, context),
          child: const Text("Login"),
        ),
      ],
    ),
  );
}

Future<void> login(String correo, String contrasenia, context) async {
  final supabase = Supabase.instance.client;
  try {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: correo,
      password: contrasenia,
    );
    final User? user = res.user;

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Transferencias()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credenciales incorrectas')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error de autenticación')),
    );
  }
}
