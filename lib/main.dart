import 'dart:convert';
import 'package:evaluacion_2/auth/LoginScreen.dart';
import 'package:evaluacion_2/auth/RegisterScreen.dart';
import 'package:evaluacion_2/screens/Listalocal.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ixqeqjsaxtuaqidpboqj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4cWVxanNheHR1YXFpZHBib3FqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDQ1NTYsImV4cCI6MjA2NTIyMDU1Nn0.Q69wKCVwLsEjrV12xYU9uVFb7XJVkEp6JDbiYEajxHM',
  );
  runApp(const SupaApp());
}

class SupaApp extends StatelessWidget {
  const SupaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Evaluación")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: const Text("Ir a Login"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registro()),
                );
              },
              child: const Text("Ir a Registro"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Listalocal()),
                );
              },
              child: const Text("API"),
            ),
            const SizedBox(height: 40),
            const Text("Sabine Vela"),
            const Text("sabinevela"),
          ],
        ),
      ),
    );
  }
  
}

