
import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/routes/app_pages.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';
import 'package:organizador_de_boletos/app/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizador de boletos',
      theme: appThemeData,
      initialRoute: Routes.splash,
      routes: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}