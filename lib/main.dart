import 'dart:convert';
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Socket/SocketServer.dart';

import 'Actividades/ListaPedidosPCScreen.dart';
import 'Actividades/Splash.dart';
import 'Clases/Mesa.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RecursosEstaticos.isPCPlatform = Platform.isWindows || Platform.isLinux;
  /*if (RecursosEstaticos.isPCPlatform) {
    DesktopWindow.setFullScreen(true);
    Server();
  }*/
  runApp(MaterialApp(
      title: "Baratie TPV",
      home: /*Splash()*/ ListaPedidosPCScreen(
        mesa: Mesa(nombre: 'Mesa 1', articulos: [/*
          Articulo(articulo: 'Cerveza', cantidad: 2, precio: 3.4),
          Articulo(id:1, articulo: 'Pepsi', cantidad: 4, precio: 1.3),
        */]),
        articulos: List<Articulo>.from(json
            .decode(
                '[{"id":1,"articulo":"Pepsi","cantidad":0,"precio":1.3,"url":"https://www.muchomasquepizza.com/alicante/wp-content/uploads/Pepsi-lata-sleek.png","observaciones":""},{"id":2,"articulo":"CocaCola","cantidad":100,"precio":1.3,"url":"https://volmesbol.com/wp-content/uploads/2017/08/cocacola.png","observaciones":null},{"id":3,"articulo":"1906 Reserva","cantidad":100,"precio":1.5,"url":"https://cervezas1906.es/wp-content/uploads/2020/06/1906.png","observaciones":""},{"id":4,"articulo":"Heineken","cantidad":100,"precio":1.5,"url":"https://www.heinekenespana.es/wp-content/uploads/2019/03/hnk.png","observaciones":""}]')
            .map((x) => Articulo.fromJson(x))),
      )));
}
