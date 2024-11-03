import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_firebase/firebase_options.dart';
import 'package:practice_firebase/pages/home_page.dart';

void main() async {
  //Memastikan semua komponen flutter terpanggil
  WidgetsFlutterBinding.ensureInitialized();
  //Menginisialisasi Firebase dengan pengaturan yang sesuai untuk platform

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Firebase CRUD',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
