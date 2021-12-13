import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends ChangeNotifier {
  static final AuthController _singleton = AuthController._internal();

  factory AuthController() {
    return _singleton;
  }

  AuthController._internal();

  final isLogged = ValueNotifier<bool>(false);
  final box = GetStorage();

  login(user) {
    box.write('token', user['access_token']);
  }

  signOut() {
    box.erase();
  }

  register() {
    //TODO: salvar no localstorage
    //box.write('token', user.body.access_token);
  }
}
