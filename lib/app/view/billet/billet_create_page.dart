import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/data/controller/billet_controller.dart';
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';
import 'package:organizador_de_boletos/app/data/repository/billet_repository.dart';

class CreateBilletPage extends StatefulWidget {
  const CreateBilletPage({Key? key, this.billet}) : super(key: key);

  final Billet? billet;

  @override
  State<CreateBilletPage> createState() => _CreateBilletPageState();
}

class _CreateBilletPageState extends State<CreateBilletPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final BilletController controller = BilletController();

  final repository = BilletRepository();

  @override
  void initState() {
    fetchForm();
    super.initState();
  }

  fetchForm() {
    _nameController.text = widget.billet?.name ?? '';
    _valueController.text = widget.billet?.price.toString() ?? '';
    _dateController.text = widget.billet?.dueDate.toString() ?? '';
  }

  create() {
    controller.createBillet(
      name: _nameController.text,
      dueDate: DateTime.tryParse(_dateController.text),
      price: int.tryParse(_valueController.text),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Boleto cadastrado com sucesso'),
      ),
    );
  }

  update() {
    widget.billet!.name = _nameController.text;
    widget.billet!.dueDate = DateTime.tryParse(_dateController.text);
    widget.billet!.price = int.tryParse(_valueController.text);

    controller.updateBillet(widget.billet!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Boleto atualizado com sucesso'),
      ),
    );
  }

  submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (widget.billet != null) {
      update();
    } else {
      create();
    }

    Navigator.pop(context);
  }

  requiredField(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.billet != null ? 'Editar' : 'Cadastrar',
        ),
        actions: [
          Visibility(
            visible: widget.billet != null ? true : false,
            child: IconButton(
              onPressed: () async {
                if (widget.billet != null) {
                  await controller.deleteBillet(widget.billet!);
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nome do boleto',
                    prefixIcon: Icon(
                      Icons.description_outlined,
                    ),
                  ),
                  validator: (value) => requiredField(value),
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  controller: _valueController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Valor',
                    prefixIcon: Icon(
                      Icons.monetization_on,
                    ),
                  ),
                  validator: (value) => requiredField(value),
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  controller: _dateController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Vencimento',
                    prefixIcon: Icon(
                      Icons.close,
                    ),
                  ),
                  readOnly: true,
                  validator: (value) => requiredField(value),
                  onTap: () => {_pickDate(context)},
                ),
                Container(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(
                      double.infinity,
                      40,
                    ),
                  ),
                  onPressed: () => {submitForm()},
                  child: const Text(
                    'Salvar',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate(context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (date == null) {
      return;
    }

    setState(() {
      _dateController.text = '$date';
    });
  }
}
