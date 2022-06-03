import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

import '../Clases/Mesa.dart';
import '../Recursos/ManejadorEstatico.dart';

void Server() async {
  // Obtiene la ip
  await getLocalIpAddress();
  // Inicializa los pedidos
  await initializeOrders();
  // Asigna ip y puerto
  RecursosEstaticos.socketServer =
      await ServerSocket.bind(InternetAddress.anyIPv4, 8888);
  print(RecursosEstaticos.socketServer.address.address +
      ' - ' +
      RecursosEstaticos.socketServer.port.toString());

  // Escucha las conexiones de los clientes
  RecursosEstaticos.socketServer.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Cliente conectado desde'
      ' ${client.remoteAddress.address}:${client.remotePort}');

  // Escucha los eventos del cliente
  client.listen(
    // Escucha los mensajes del cliente
    (Uint8List data) async {
      await Future.delayed(const Duration(seconds: 1));
      final message = String.fromCharCodes(data);
      if (message != '' && message != 'salir') {
        client.write('Recibido');
        RecursosEstaticos.respuestasCliente.add(message);
      } else {
        client.write('Hasta luego');
        client.close();
      }
    },

    // Recoge los errors
    onError: (error) {
      print(error);
      client.close();
    },

    // Recoge la salida del cliente
    onDone: () {
      print('Ciente desconectado');
      client.close();
    },
  );
}

Future<void> getLocalIpAddress() async {
  for (var interface in await NetworkInterface.list()) {
    print('== Interface: ${interface.name} ==');
    for (var addr in interface.addresses) {
      RecursosEstaticos.ip.add(interface.name + ' - ' + addr.address);
    }
  }
}

Future<void> initializeOrders() async {
  RecursosEstaticos.pedidos = {};
  Response response = await ManejadorEstatico.getRequest('mesas');
  List<Mesa> mesas =
      List<Mesa>.from(json.decode(response.body).map((x) => Mesa.fromJson(x)));

  for (Mesa m in mesas) {
    RecursosEstaticos.pedidos[m] = [];
  }

  for(var val in RecursosEstaticos.pedidos.keys){
    print(val.id.toString() + " - " + val.nombre);
    if(val.id == 1){
      RecursosEstaticos.pedidos[val].add(Articulo());
      RecursosEstaticos.pedidos[val].add(Articulo());
    }
  }

  print(RecursosEstaticos.pedidos);
}
