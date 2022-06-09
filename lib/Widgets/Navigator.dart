import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';

import '../Actividades/AcercaDeScreen.dart';
import '../Actividades/AjustesScreen.dart';
import '../Actividades/AyudaScreen.dart';
import '../Actividades/LoginScreen.dart';
import '../Recursos/RecursosEstaticos.dart';
import 'Delimitadores.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //print(RecursosEstaticos.usuario.nombre);
    final width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              alignment: Alignment.bottomLeft,
              // Muestra el encabezado
              child: DrawerHeader(
                child: Column(
                  children: [
                    Text(
                      'Bienvenido de nuevo -    ' +
                          RecursosEstaticos.usuario.nombre,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            // Muestra el menu de herramientas
            Header("Herramientas"),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () =>
                  {ManejadorEstatico.LanzarActividad(context, AjustesScreen())},
            ),
            Space(),
            // Muestra la informacion
            Header("Informacion"),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Ayuda'),
              onTap: () =>
                  {ManejadorEstatico.LanzarActividad(context, AyudaScreen())},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () => {
                ManejadorEstatico.LanzarActividad(context, AcercaDeScreen())
              },
            ),
            Space(),
            // Muestra salida
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Cerrar Sesión'),
              onTap: () {
                if (!RecursosEstaticos.isPCPlatform) {
                  // Eliminara el login de la bd si existe
                }
                ManejadorEstatico.RemplazarActividad(context, LoginScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Salir'),
              onTap: () => {
                RecursosEstaticos.isPCPlatform ? exit(0) : SystemNavigator.pop()
              },
            ),
          ],
        ),
      ),
    );
  }
}
