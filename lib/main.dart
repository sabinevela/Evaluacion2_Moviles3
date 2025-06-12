import 'package:evaluacion_2/screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ixqeqjsaxtuaqidpboqj.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml4cWVxanNheHR1YXFpZHBib3FqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDQ1NTYsImV4cCI6MjA2NTIyMDU1Nn0.Q69wKCVwLsEjrV12xYU9uVFb7XJVkEp6JDbiYEajxHM',
  );
  runApp(const SupaApp());
}

class SupaApp extends StatelessWidget {
  const SupaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Welcome(),  
    );
  }
}


