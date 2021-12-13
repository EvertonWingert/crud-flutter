import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';
import 'package:organizador_de_boletos/app/view/auth/sign_in_page.dart';
import 'package:organizador_de_boletos/app/view/auth/sign_up_page.dart';
import 'package:organizador_de_boletos/app/view/billet/billet_create_page.dart';
import 'package:organizador_de_boletos/app/view/home/home_page.dart';
import 'package:organizador_de_boletos/app/view/splash/splash_page.dart';

class AppPages {
  static final routes = {
    Routes.splash: (_) => const SplashPage(),
    Routes.signin: (_) => const SignInPage(),
    Routes.signup: (_) => const SignUp(),
    Routes.home: (_) => const HomePage(),
    Routes.createBillet: (_) => const CreateBilletPage(),
    Routes.editBillet: (BuildContext context) => CreateBilletPage(
          billet: ModalRoute.of(context)!.settings.arguments as Billet,
        ),
  };
}
