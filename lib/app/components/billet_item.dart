import 'package:flutter/material.dart';
import 'package:organizador_de_boletos/app/data/controller/billet_controller.dart';
import 'package:organizador_de_boletos/app/data/model/billet_model.dart';
import 'package:organizador_de_boletos/app/routes/app_routes.dart';

class BilletListItem extends StatefulWidget {
  const BilletListItem({Key? key, required this.billet}) : super(key: key);
  final Billet billet;

  @override
  State<BilletListItem> createState() => _BilletListItemState();
}

class _BilletListItemState extends State<BilletListItem> {
  final BilletController controller = BilletController();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.billet.id.toString()),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          setState(() {
            controller.deleteBillet(widget.billet);
          });
        } else {
          return;
        }
      },
      child: ListTile(
        title: Text(widget.billet.name!),
        subtitle: Text(
          'Vence em ${widget.billet.dueDate!.day}/${widget.billet.dueDate!.month}',
        ),
        onTap: () => {
          Navigator.pushNamed(
            context,
            Routes.editBillet,
            arguments: widget.billet,
          )
        },
      ),
    );
  }
}
