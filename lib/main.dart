import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/kav_screen.dart';
import 'viewmodels/login_viewmodel.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        title: 'MVVM Flutter App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: KavScreen(),
      ),
    );
  }
}
