import 'package:flutter/material.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Widgets/Navigator.dart';

import '../Widgets/InkWellBuilder.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(RecursosEstaticos.appName)),
      body: GridView(
          padding: const EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: RecursosEstaticos.isPCPlatform ? 400 : 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: RecursosEstaticos.isPCPlatform ? 40 : 20,
            mainAxisSpacing: RecursosEstaticos.isPCPlatform ? 40 : 20,
          ),
          children: RecursosEstaticos.isPCPlatform
              ? RecursosEstaticos.opcionesDisponiblesPC
                  .map((e) => InkWellBuilder(e, size: 26))
                  .toList()
              : RecursosEstaticos.opcionesDisponiblesMovil
                  .map((e) => InkWellBuilder(e, size: 18))
                  .toList()),
      drawer: NavDrawer(),
    );
  }
}
