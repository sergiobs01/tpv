import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../Clases/Mesa.dart';
import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/Delimitadores.dart';

class EditorMesasScreen extends StatefulWidget {
  Mesa mesa;
  bool btnAbierto;

  EditorMesasScreen({@required this.mesa, @required this.btnAbierto});

  @override
  State<EditorMesasScreen> createState() => _EditorMesasScreenState();
}

class _EditorMesasScreenState extends State<EditorMesasScreen> {
  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var height = size.height;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          widget.btnAbierto
              ? Container(
                  child: FloatingActionButton(
                    heroTag: 4,
                    onPressed: () async {
                      AlertDialog alert = RecursosEstaticos.alertDialogLoading;
                      if (widget.mesa.nombre != null) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                        Response r =
                            await ManejadorEstatico.putRequest('mesas', {
                          'id': widget.mesa.id,
                          'nombre': widget.mesa.nombre,
                        });
                        Navigator.pop(context, true);
                        Mesa c = Mesa.fromJson(jsonDecode(r.body.replaceAll('}', ',"articulos":[]}')));

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
                          content: Text('El nombre no puede quedar vacio'),
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
          widget.btnAbierto
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

                      Response r = await ManejadorEstatico.deleteRequest(
                          'mesas', widget.mesa.id);
                      Navigator.pop(context, true);
                      Mesa c = Mesa.fromJson(jsonDecode(r.body.replaceAll('}', ',"articulos":[]}')));

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
              if (widget.mesa.id == null) {
                if (widget.mesa.nombre != null) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );

                  Response r = await ManejadorEstatico.postRequest('mesas', {
                    'nombre': widget.mesa.nombre,
                  });
                  Navigator.pop(context, true);
                  Mesa c = Mesa.fromJson(jsonDecode(r.body.replaceAll('}', ',"articulos":[]}')));

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
                    content: Text('El nombre no puede quedar vacio'),
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
                  widget.btnAbierto = !widget.btnAbierto;
                });
              }
            },
            backgroundColor: Colors.blue,
            child: Icon(widget.mesa.id == null
                ? Icons.add_rounded
                : widget.btnAbierto
                    ? Icons.close_rounded
                    : Icons.more_vert_rounded),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(RecursosEstaticos.mesasLabel),
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
                    'Nombre de mesa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(
                        widget.mesa.nombre ?? 'Haga clic aquí para añadir'),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text(
                            'Escriba el nombre de la mesa'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(
                                  () => widget.mesa.nombre = _controller.text);
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
