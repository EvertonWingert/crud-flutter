import 'package:flutter/foundation.dart';
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';
import 'package:organizador_de_boletos/app/data/repository/billet_repository.dart';

class BilletController extends ChangeNotifier {
  static final BilletController _singleton = BilletController._internal();

  factory BilletController() {
    return _singleton;
  }

  BilletController._internal();

  final billets = ValueNotifier<List<Billet>>([]);
  final repository = BilletRepository();
  bool isLoading = false;

  Future fetchAllbillets() async {
    isLoading = true;
    final billets = await repository.getBillets();
    this.billets.value = billets;
    isLoading = false;
    notifyListeners();
  }

  Future createBillet(
      {required String? name,
      required DateTime? dueDate,
      required int? price}) async {
    final billet = Billet(
      name: name,
      dueDate: dueDate,
      price: price,
    );

    try {
      await repository.createBillet(billet);
      billets.value.add(billet);
      notifyListeners();
    } catch (e) {
      print(e);
    }

    billets.notifyListeners();
  }

  updateBillet(Billet billet) async {
    isLoading = true;
    try {
      await repository.updateBillet(billet);
      billets.value.removeWhere((element) => element.id == billet.id);
      billets.value.add(billet);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }

    billets.notifyListeners();
  }

  deleteBillet(Billet billet) async {
    final id = billet.id;

    await repository.deleteBillet(id!);
    billets.value.remove(billet);

    billets.notifyListeners();
  }

  generateBilletId() {
    return billets.value.length + 1;
  }

  getUnpaidBilletsCount() {
    return billets.value.length;
  }

  getBilletsSum() {
    var total = 0.0;

    for (int i = 0; i < billets.value.length; i++) {
      total += billets.value[i].price ?? 0.0;
    }

    return total;
  }
}
