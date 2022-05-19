import 'package:flutter/material.dart';
import 'package:tpv/InternalDB/Login.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'dart:io' show Platform;

import '../Recursos/ManejadorEstatico.dart';
import '../Socket/SocketServer.dart';
import 'LoginScreen.dart';

class Splash extends StatelessWidget {
  Future<void> _load(BuildContext ctx) async {
    if (!RecursosEstaticos.isPCPlatform) {
      // INICIALIZA LA BD (AUN NO CREADA)
      //await ManejadorEstatico.iniciarDb(ctx);
    }
    return Future<void>.delayed(const Duration(seconds: 3), () {
      ManejadorEstatico.RemplazarActividad(ctx, LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _load(context),
        builder: (context, AsyncSnapshot<void> snapshot) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(RecursosEstaticos.logoNormal),
          );
        },
      ),
    );
  }
}
