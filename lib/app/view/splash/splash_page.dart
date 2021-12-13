import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  navigate() {
    final box = GetStorage();

    Future.delayed(const Duration(seconds: 2), () {
      if (box.read('token') == null) {
        Navigator.of(context).pushReplacementNamed(Routes.signin);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'PagBoleto',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
