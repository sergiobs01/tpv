import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/AjustesScreen.dart';
import 'package:tpv/Actividades/AlmacenScreen.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Actividades/DescuentosScreen.dart';
import 'package:tpv/Clases/Descuento.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

import '../Clases/Articulo.dart';
import '../Clases/Cliente.dart';
import '../Recursos/ManejadorEstatico.dart';

class InkWellBuilder extends StatelessWidget {
  int opcion;
  double size = 0;

  //dInkWell(this._text);
  InkWellBuilder(this.opcion, {this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Response response;
        bool running = true;
        switch (opcion) {
          case 0:
            //ManejadorEstatico.LanzarActividad(context, Menu());
            break;
          case 1:
            AlertDialog alert = RecursosEstaticos.alertDialogLoading;
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            final response = await ManejadorEstatico.getRequest('almacen');
            List<Articulo> articulos = List<Articulo>.from(
                json.decode(response.body).map((x) => Articulo.fromJson(x)));
            Navigator.pop(context, true);
            ManejadorEstatico.LanzarActividad(
                context,
                AlmacenScreen(
                  articulos: articulos,
                ));
            break;
          case 2:
            AlertDialog alert = AlertDialog(
              content: Container(
                //width: 80,
                //height: 50,
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text('Cargando...')),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    running = false;
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            response = await ManejadorEstatico.getRequest('cliente');
            List<Cliente> clientes = List<Cliente>.from(
                json.decode(response.body).map((x) => Cliente.fromJson(x)));
            if (running) {
              Navigator.pop(context, false);
              ManejadorEstatico.LanzarActividad(context,
                  ClientesScreen(clientes: clientes, crearDescuento: false));
            }
            break;
          case 3:
            AlertDialog alert = AlertDialog(
              content: Container(
                //width: 80,
                //height: 50,
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text('Cargando...')),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    running = false;
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
            response = await ManejadorEstatico.getRequest('descuento');
            List<Descuento> descuentos = List<Descuento>.from(
                json.decode(response.body).map((x) => Descuento.fromJson(x)));
            response = await ManejadorEstatico.getRequest('cliente');
            List<Cliente> clientes = List<Cliente>.from(
                json.decode(response.body).map((x) => Cliente.fromJson(x)));
            descuentos = descuentos.where((descuento) {
              clientes.where((cliente) {
                if (descuento.clienteId == cliente.id) {
                  descuento.clienteNom =
                      cliente.nombre + ' ' + cliente.apellidos;
                }
                return true;
              }).toList();
              return true;
            }).toList();
            if (running) {
              Navigator.pop(context, false);
              ManejadorEstatico.LanzarActividad(
                  context, DescuentosScreen(descuentos: descuentos));
            }

            break;
          case 4:
            break;
          case 5:
            ManejadorEstatico.LanzarActividad(context, AjustesScreen());
            break;
          default:
            break;
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Text(
          RecursosEstaticos.opciones[opcion],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: size == 0 ? 18 : size,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.7),
              Colors.blue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
