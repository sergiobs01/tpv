import 'package:flutter/material.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Widgets/InkWellBuilder.dart';

import '../Clases/Mesa.dart';

class SeleccionarMesaScreen extends StatelessWidget {
  final url =
      'https://cdn.icon-icons.com/icons2/2054/PNG/128/dinning_table_dinner_table_dining_room_chairs_table_icon_124435.png';

  @override
  Widget build(BuildContext context) {
    List<Mesa> mesas = [];
    for (var a in RecursosEstaticos.pedidos.values) {
      mesas.add(a);
    }
    return Scaffold(
        appBar: AppBar(title: Text(RecursosEstaticos.seleccion)),
        body: GridView(
          padding: const EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: RecursosEstaticos.isPCPlatform ? 400 : 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: RecursosEstaticos.isPCPlatform ? 40 : 20,
            mainAxisSpacing: RecursosEstaticos.isPCPlatform ? 40 : 20,
          ),
          children: mesas
              .map((mesa) => InkWellBuilder(
                    6,
                    size: RecursosEstaticos.isPCPlatform ? 28 : 18,
                    url: url,
                    mesa: mesa,
                  ))
              .toList(),
        ));
  }
}
