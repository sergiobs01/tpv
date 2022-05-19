import 'dart:io';

import 'dart:typed_data';

import 'package:tpv/Recursos/RecursosEstaticos.dart';

void Client(String ip) async {

  // Conecta al socket
  try{
    RecursosEstaticos.socket = await Socket.connect(ip, 8888);
    print('Conectado a: ${RecursosEstaticos.socket.remoteAddress.address}:${RecursosEstaticos.socket.remotePort}');
    RecursosEstaticos.conectado = true;

    // Escucha del servidor
    RecursosEstaticos.socket.listen(

      // Recoge los datos del server
          (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
      },

      // Recoge los errores
      onError: (error) {
        print(error);
        RecursosEstaticos.socket.destroy();
      },

      // Recoge la salida
      onDone: () {
        print('Cliente desconectado.');
        RecursosEstaticos.socket.destroy();
      },
    );
  } on Exception catch (_) {
    RecursosEstaticos.conectado = false;
  }
}

Future<void> sendMessage(String message) async {
  print('Enviado: $message');
  RecursosEstaticos.socket.write(message);
  await Future.delayed(Duration(seconds: 2));
}