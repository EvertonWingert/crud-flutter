import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/components/billet_item.dart';
import 'package:organizador_de_boletos/app/data/controller/auth_controller.dart';
import 'package:organizador_de_boletos/app/data/controller/billet_controller.dart';
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final billetController = BilletController();
  final authController = AuthController();

  //initState getBillets
  @override
  void initState() {
    super.initState();
    billetController.fetchAllbillets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, Routes.createBillet),
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          height: 152,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text.rich(
                  TextSpan(
                    text: "Olá, ",
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                          text: "Usuário",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => {
                    authController.signOut(),
                    Navigator.pushNamed(context, Routes.signin),
                  },
                  child: Text('Sair'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 160,
            child: Stack(
              children: [
                Container(
                  height: 90,
                  color: Theme.of(context).primaryColor,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Boletos a pagar '),
                            ValueListenableBuilder(
                              valueListenable: billetController.billets,
                              builder: (BuildContext context,
                                  List<Billet> billets, Widget? child) {
                                return Text(
                                  '${billetController.getUnpaidBilletsCount()}',
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Total a pagar'),
                            ValueListenableBuilder(
                              valueListenable: billetController.billets,
                              builder: (BuildContext context, billets,
                                  Widget? child) {
                                return Text(
                                  r'R$ ' +
                                      billetController
                                          .getBilletsSum()
                                          .toString(),
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: billetController.billets,
              builder:
                  (BuildContext context, List<Billet> billets, Widget? child) {
                return RefreshIndicator(
                  onRefresh: () => billetController.fetchAllbillets(),
                  child: Visibility(
                    visible: billets.isNotEmpty,
                    replacement: const Center(
                      child: Text('Nenhum boleto encontrado'),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: billets.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: BilletListItem(
                            billet: billets[index],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
