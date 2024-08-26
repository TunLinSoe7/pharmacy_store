import 'package:flutter/material.dart';
import 'package:pharmacy_store/firebase_options.dart';
import 'package:pharmacy_store/network/auth_data_agent/auth_gate.dart';
import 'package:pharmacy_store/provider/whist_list_provider.dart';
import 'package:pharmacy_store/utils/themes/text_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>WhistListProvider()),
    ],child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: textTheme
      ),
      home: const AuthGate(),
    );
  }
}
