import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Clases/Cliente.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

import '../Recursos/ManejadorEstatico.dart';
import '../Widgets/Delimitadores.dart';

class EditorClienteScreen extends StatefulWidget {
  Cliente cliente;
  bool _btnAbierto = false;

  EditorClienteScreen({this.cliente});

  @override
  State<EditorClienteScreen> createState() => _EditorClienteScreenState();
}

class _EditorClienteScreenState extends State<EditorClienteScreen> {
  @override
  Widget build(BuildContext context) {
    widget.cliente.email ??= '';
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var height = size.height;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget._btnAbierto
              ? Container(
                  child: FloatingActionButton(
                    heroTag: 4,
                    onPressed: () async {
                      AlertDialog alert = RecursosEstaticos.alertDialogLoading;
                      if (widget.cliente.nombre.isNotEmpty &&
                          widget.cliente.apellidos.isNotEmpty) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                        Response r =
                            await ManejadorEstatico.putRequest('cliente', {
                          'id': widget.cliente.id,
                          'nombre': widget.cliente.nombre,
                          'apellidos': widget.cliente.apellidos,
                          'email': widget.cliente.email,
                        });
                        Navigator.pop(context, true);
                        Cliente c = Cliente.fromJson(jsonDecode(r.body));

                        if (c.error.isNotEmpty) {
                          alert = AlertDialog(
                            content: Text(c.error),
                            title: Text('Error'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('Aceptar'))
                            ],
                          );
                        } else {
                          alert = AlertDialog(
                            content: Text('Actualizado con exito'),
                            title: Text('Advertencia'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context, true);
                                    Navigator.pop(context, true);
                                  },
                                  child: Text('Aceptar'))
                            ],
                          );
                        }
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        alert = AlertDialog(
                          content: Text(
                              'El nombre y apellidos no puede quedar vacio'),
                          title: Text('Error'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Aceptar'))
                          ],
                        );
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                    child: const Icon(Icons.save_rounded),
                  ),
                )
              : Container(),
          widget._btnAbierto
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: FloatingActionButton(
                    heroTag: 3,
                    onPressed: () async {
                      AlertDialog alert = RecursosEstaticos.alertDialogLoading;
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                      Response r =
                      await ManejadorEstatico.deleteRequest('cliente', widget.cliente.id);
                      Navigator.pop(context, true);
                      Cliente c = Cliente.fromJson(jsonDecode(r.body));

                      if (c.error.isNotEmpty) {
                        alert = AlertDialog(
                          content: Text(c.error),
                          title: Text('Error'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Aceptar'))
                          ],
                        );
                      } else {
                        alert = AlertDialog(
                          content: Text('Eliminado con exito'),
                          title: Text('Advertencia'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.pop(context, true);
                                  Navigator.pop(context, true);
                                },
                                child: Text('Aceptar'))
                          ],
                        );
                      }

                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    child: const Icon(Icons.delete_rounded),
                  ),
                )
              : Container(),
          FloatingActionButton(
            heroTag: 2,
            onPressed: () async {
              AlertDialog alert = RecursosEstaticos.alertDialogLoading;
              if (widget.cliente.id == null) {
                if (widget.cliente.nombre.isNotEmpty &&
                    widget.cliente.apellidos.isNotEmpty) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );

                  Response r = await ManejadorEstatico.postRequest('cliente', {
                    'nombre': widget.cliente.nombre,
                    'apellidos': widget.cliente.apellidos,
                    'email': widget.cliente.email,
                  });
                  Navigator.pop(context, true);
                  Cliente c = Cliente.fromJson(jsonDecode(r.body));

                  if (c.error.isNotEmpty) {
                    alert = AlertDialog(
                      content: Text(c.error),
                      title: Text('Error'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text('Aceptar'))
                      ],
                    );
                  } else {
                    alert = AlertDialog(
                      content: Text('Agregado con exito'),
                      title: Text('Advertencia'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              Navigator.pop(context, true);
                              Navigator.pop(context, true);
                            },
                            child: Text('Aceptar'))
                      ],
                    );
                  }

                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else {
                  alert = AlertDialog(
                    content:
                        Text('El nombre y apellidos no puede quedar vacio'),
                    title: Text('Error'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('Aceptar'))
                    ],
                  );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }
              } else {
                setState(() {
                  widget._btnAbierto = !widget._btnAbierto;
                });
              }
            },
            backgroundColor: Colors.blue,
            child: Icon(widget.cliente.id == null
                ? Icons.add_rounded
                : widget._btnAbierto
                    ? Icons.close_rounded
                    : Icons.more_vert_rounded),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(RecursosEstaticos.clientesLabel),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5),
            ),
            Space(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Nombre',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.cliente.nombre.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.cliente.nombre),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba el nombre nuevo'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() =>
                                  widget.cliente.nombre = _controller.text);
                              Navigator.pop(context, true);
                            },
                            child: const Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
                    },
                  )
                ],
              ),
            ),
            Space(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Apellidos',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.cliente.apellidos.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.cliente.apellidos),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba los apellidos nuevos'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() =>
                                  widget.cliente.apellidos = _controller.text);
                              Navigator.pop(context, true);
                            },
                            child: const Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
                    },
                  )
                ],
              ),
            ),
            Space(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.cliente.email.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.cliente.email),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba el email nuevo'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() =>
                                  widget.cliente.email = _controller.text);
                              Navigator.pop(context, true);
                            },
                            child: const Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
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
                    },
                  )
                ],
              ),
            ),
            Space(),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                  'Ayuda: Para cambiar los datos haga clic sobre ellos.'),
            )
          ],
        ),
      ),
    );
  }
}