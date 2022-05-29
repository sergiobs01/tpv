import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Clases/Articulo.dart';

import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/Delimitadores.dart';

class EditorAlmacenScreen extends StatefulWidget {
  bool _btnAbierto = false;
  Articulo articulo;

  EditorAlmacenScreen({this.articulo});

  @override
  State<EditorAlmacenScreen> createState() => _EditorAlmacenScreenState();
}

class _EditorAlmacenScreenState extends State<EditorAlmacenScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.articulo.url);
    widget.articulo.observaciones ??= '';
    widget.articulo.url ??= '';
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
                      if (widget.articulo.articulo.isNotEmpty &&
                          widget.articulo.precio != null &&
                          widget.articulo.cantidad != null) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                        Response r =
                            await ManejadorEstatico.putRequest('almacen', {
                          'id': widget.articulo.id,
                          'articulo': widget.articulo.articulo,
                          'cantidad': widget.articulo.cantidad,
                          'precio': widget.articulo.precio,
                          'url': widget.articulo.url,
                          'observaciones': widget.articulo.observaciones,
                        });
                        Navigator.pop(context, true);
                        Articulo a = Articulo.fromJson(jsonDecode(r.body));

                        if (a.error.isNotEmpty) {
                          alert = AlertDialog(
                            content: Text(a.error),
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

                      Response r = await ManejadorEstatico.deleteRequest(
                          'almacen', widget.articulo.id);
                      Navigator.pop(context, true);
                      Articulo a = Articulo.fromJson(jsonDecode(r.body));

                      if (a.error.isNotEmpty) {
                        alert = AlertDialog(
                          content: Text(a.error),
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
              if (widget.articulo.id == null) {
                if (widget.articulo.articulo.isNotEmpty &&
                    widget.articulo.precio != null &&
                    widget.articulo.cantidad != null) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );

                  Response r = await ManejadorEstatico.postRequest('almacen', {
                    'articulo': widget.articulo.articulo,
                    'cantidad': widget.articulo.cantidad,
                    'precio': widget.articulo.precio,
                    'url': widget.articulo.url,
                    'observaciones': widget.articulo.observaciones,
                  });
                  Navigator.pop(context, true);
                  Articulo a = Articulo.fromJson(jsonDecode(r.body));

                  if (a.error.isNotEmpty) {
                    alert = AlertDialog(
                      content: Text(a.error),
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
                  widget._btnAbierto = !widget._btnAbierto;
                });
              }
            },
            backgroundColor: Colors.blue,
            child: Icon(widget.articulo.id == null
                ? Icons.add_rounded
                : widget._btnAbierto
                    ? Icons.close_rounded
                    : Icons.more_vert_rounded),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(RecursosEstaticos.articuloLabel),
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
                    child: Text(widget.articulo.articulo.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.articulo.articulo),
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
                                  widget.articulo.articulo = _controller.text);
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
                    'Cantidad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.articulo.cantidad == null
                        ? 'Haga clic aquí para añadir'
                        : widget.articulo.cantidad.toString()),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba la nueva cantidad'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() => widget.articulo.cantidad =
                                  int.parse(_controller.text));
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
                    'Precio',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.articulo.precio == null
                        ? 'Haga clic aquí para añadir'
                        : widget.articulo.precio.toString()),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba el nuevo precio'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() => widget.articulo.precio =
                                  double.parse(_controller.text));
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
                    'URL',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.articulo.url.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.articulo.url),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba la nueva url de imagen'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(
                                  () => widget.articulo.url = _controller.text);
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
                    'Observaciones',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(widget.articulo.observaciones.isEmpty
                        ? 'Haga clic aquí para añadir'
                        : widget.articulo.observaciones),
                    onTap: () {
                      final _controller = TextEditingController();
                      AlertDialog alert = AlertDialog(
                        title: const Text('Escriba las observaciones'),
                        content: TextField(
                          controller: _controller,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() => widget.articulo.observaciones =
                                  _controller.text);
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
