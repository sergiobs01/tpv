import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Socket/SocketClient.dart';
import 'package:tpv/Widgets/Delimitadores.dart';

import '../Clases/Usuario.dart';

class AjustesScreen extends StatefulWidget {
  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _clientController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(RecursosEstaticos.ajustesLabel),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cambio de contraseña
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Header(
                "Cambiar contraseña",
                size: 25,
              ),
            ), // Contenedor principal
            Container(
              margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
              child: TextFormField(
                controller: _passController,
                decoration: const InputDecoration(
                  labelText: 'Escriba la nueva contraseña',
                ),
              ),
            ), // Formulario
            Container(
              width: width - 20,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () async {
                  if (_passController.text.isNotEmpty) {
                    var response = await ManejadorEstatico.putRequest('login', {
                      'usuario': RecursosEstaticos.usuario.usuario,
                      'contrasena': _passController.text,
                    });
                    Usuario usuario =
                        Usuario.fromJson(jsonDecode(response.body));
                    if (usuario.error != '') {
                      AlertDialog dialog = AlertDialog(
                        title: const Text('Error'),
                        content: Text(usuario.error),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'))
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dialog;
                        },
                      );
                    } else {
                      AlertDialog dialog = AlertDialog(
                        title: const Text('Atencion'),
                        content: const Text('Se ha cambiado la contraseña'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'))
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dialog;
                        },
                      );
                      RecursosEstaticos.usuario.contrasena = usuario.contrasena;
                    }
                  } else {
                    AlertDialog dialog = AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'La contraseña nueva no puede estar vacía'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'))
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      },
                    );
                  }
                },
                child: const Text(
                  "Cambiar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ), // Botón
            Space(),
            // Cambio de nombre
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Header(
                "Cambiar nombre empleado",
                size: 25,
              ),
            ), // Contenedor principal
            Container(
              margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Escriba el nombre al que desea cambiar',
                ),
              ),
            ), // Formulario
            Container(
              width: width - 20,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () async {
                  if (_nameController.text.isNotEmpty) {
                    var response = await ManejadorEstatico.putRequest('login', {
                      'usuario': RecursosEstaticos.usuario.usuario,
                      'contrasena': RecursosEstaticos.usuario.contrasena,
                      'nombre': _nameController.text,
                    });
                    Usuario usuario =
                        Usuario.fromJson(jsonDecode(response.body));
                    if (usuario.error != '') {
                      AlertDialog dialog = AlertDialog(
                        title: const Text('Error'),
                        content: Text(usuario.error),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'))
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dialog;
                        },
                      );
                    } else {
                      AlertDialog dialog = AlertDialog(
                        title: const Text('Atencion'),
                        content: const Text(
                            'Se ha cambiado el nombre del empleado correctamente'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Aceptar'))
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (context) {
                          return dialog;
                        },
                      );
                      RecursosEstaticos.usuario.nombre = usuario.nombre;
                    }
                  } else {
                    AlertDialog dialog = AlertDialog(
                      title: const Text('Error'),
                      content: const Text('El nombre no puede estar vacío'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'))
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      },
                    );
                  }
                },
                child: const Text(
                  "Cambiar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ), // Botón
            Space(),
            /*// Ajustes de mesas
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Header(
                "Cantidad de mesas en el establecimiento",
                size: 25,
              ),
            ), // Contenedor principal
            Container(
              margin: const EdgeInsets.only(left: 30, bottom: 5, right: 30),
              child: TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Escriba la cantidad de mesas',
                ),
              ),
            ), // Formulario*/
            RecursosEstaticos.isPCPlatform
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Header(
                            RecursosEstaticos.ip.length>1?'Sus IPs':'Su IP',
                            size: 25,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: RecursosEstaticos.ip
                              .map((e) => Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30, top: 10),
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                : RecursosEstaticos.conectado
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Header(
                                "Conectar a PC",
                                size: 25,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 30, bottom: 5, right: 30, top: 10),
                                child: Text(
                                  'Conectado a ' +
                                      RecursosEstaticos.socket.address.host,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                                width: width - 20,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                alignment: Alignment.bottomRight,
                                child: TextButton(
                                  onPressed: () async {
                                    await RecursosEstaticos.socket.close();
                                    setState(() {
                                      RecursosEstaticos.conectado = false;
                                    });
                                    AlertDialog dialog = AlertDialog(
                                      title: const Text('Atencion'),
                                      content: const Text(
                                          'Se ha desconectado del servidor'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Aceptar'))
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialog;
                                      },
                                    );
                                  },
                                  child: Text('Desconectar'),
                                )),
                          ],
                        ),
                      ) // DESCONECTAR
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Header(
                                "Conectar a PC",
                                size: 25,
                              ),
                            ), // Contenedor principal
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30, bottom: 5, right: 30),
                              child: TextFormField(
                                controller: _clientController,
                                decoration: const InputDecoration(
                                  labelText: 'Escriba la ip del PC',
                                ),
                              ),
                            ), // Formulario
                            Container(
                              width: width - 20,
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () async {
                                  if (!RecursosEstaticos.conectado) {
                                    if (_clientController.text.isNotEmpty) {
                                      String ipCompleta =
                                          _clientController.text;
                                      await connectClient(ipCompleta);
                                      if (!RecursosEstaticos.conectado) {
                                        AlertDialog dialog = AlertDialog(
                                          title: const Text('Error'),
                                          content: const Text(
                                              "Direccion incorrecta"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Aceptar'))
                                          ],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return dialog;
                                          },
                                        );
                                      } else {
                                        AlertDialog dialog = AlertDialog(
                                          title: const Text('Atencion'),
                                          content:
                                              const Text('Conexión correcta'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Aceptar'))
                                          ],
                                        );
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return dialog;
                                          },
                                        );
                                      }
                                    } else {
                                      AlertDialog dialog = AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'La direccion no puede estar vacía'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Aceptar'))
                                        ],
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return dialog;
                                        },
                                      );
                                    }
                                  } else {
                                    AlertDialog dialog = AlertDialog(
                                      title: const Text('Error'),
                                      content:
                                          const Text("Ya esta conectado al PC"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Aceptar'))
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return dialog;
                                      },
                                    );
                                  }
                                },
                                child: const Text(
                                  "Conectar",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ), // Botón
                          ],
                        ),
                      ), // CONECTAR
          ],
        ),
      ),
    );
  }
}
