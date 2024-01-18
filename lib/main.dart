
import 'package:flutter/material.dart';
import 'package:transaksi_apps/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}