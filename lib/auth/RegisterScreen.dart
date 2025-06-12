import 'package:evaluacion_2/auth/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REGISTER")),

      body: formularioRegistro(context),
    );
  }
}

Widget formularioRegistro(context) {
  TextEditingController _correo = TextEditingController();
  TextEditingController _contrasenia = TextEditingController();

  return Center(
    child: (Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Registro", style: TextStyle(fontSize: 40)),
        TextField(
          controller: _correo,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Correo"),
          ),
        ),
        Container(height: 10),
        TextField(
          controller: _contrasenia,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Contraseña"),
          ),
        ),

        ElevatedButton(onPressed: () => registrarse(_correo.text, _contrasenia.text, context), child: Text("Registro")),
      ],
    )),
  );
}

Future <void> registrarse(String correo, String contrasenia, context) async {
  final supabase = Supabase.instance.client;
  final AuthResponse res = await supabase.auth.signUp(
    email: correo,
    password: contrasenia,
  );
  final Session? session = res.session;
  final User? user = res.user;

  print(session);

  if(session?.user.id != null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
  }else{
    print("ERROR");
  }

}