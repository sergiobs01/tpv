import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tpv/Actividades/LoginScreen.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/InternalDB/DBHelper.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';

import '../Clases/Mesa.dart';
import '../Clases/Usuario.dart';

class RecursosEstaticos {
  static String logoNormal = 'assets/logo.jpg';
  static bool isPCPlatform;
  static const appName = 'Baratie TPV';
  static String ajustesLabel = 'Ajustes';
  static String clientesLabel = 'Clientes';
  static String articuloLabel = 'Articulos';
  static String descuentoLabel = 'Descuentos';
  static String listapedidos = 'Pedido de ';
  static String seleccion = 'Selección de mesa';
  static String mesasLabel = 'Mesas';
  static String filtradoLabel = 'Escriba para filtrar';
  static const wsUrl = 'http://wstpv.azurewebsites.net/api/';
  //static const wsUrl = 'https://localhost:44339/api/';
  static Usuario usuario;
  static const opciones = {
    0: 'Caja',
    1: 'Almacen',
    2: 'Clientes',
    3: 'Descuentos',
    4: 'Mesas',
    5: 'Ajustes',
  };
  static var opcionesDisponiblesPC = {0, 1, 2, 3, 4, 5};
  static var opcionesDisponiblesMovil = {0, 2, 5};
  static DBHelper Database;
  static Socket socket;
  static ServerSocket socketServer;
  static bool conectado = false;
  static List<String> ip = [];
  static Map<int, Mesa> pedidos = {};
  static final alertDialogLoading = AlertDialog(
    content: Container(
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
  );
  static final List<Socket> clientes = [];


}
