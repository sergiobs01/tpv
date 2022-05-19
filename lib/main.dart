import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Socket/SocketServer.dart';

import 'Actividades/Splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RecursosEstaticos.isPCPlatform = Platform.isWindows || Platform.isLinux;
  if (RecursosEstaticos.isPCPlatform) {
    DesktopWindow.setFullScreen(true);
    Server();
  }
  runApp(MaterialApp(
      title: "App",
      home: Splash()));
}