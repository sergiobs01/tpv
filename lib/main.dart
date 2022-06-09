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
  if (RecursosEstaticos.isPCPlatform) {
    DesktopWindow.setFullScreen(true);
    Server();
  }
  runApp(MaterialApp(
      title: "Baratie TPV",
      home: Splash()));
}
