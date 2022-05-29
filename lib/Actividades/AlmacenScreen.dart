import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpv/Clases/Articulo.dart';

import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/ListViewBuilder.dart';
import 'EditorAlmacenScreen.dart';

class AlmacenScreen extends StatefulWidget {
  final _busquedaController = TextEditingController();
  List<Articulo> articulos;

  bool _orderbyNom = false;
  bool _orderbyCant = false;
  bool _orderbyPrecio = false;
  bool _orderbyObs = false;

  AlmacenScreen({this.articulos});

  @override
  State<AlmacenScreen> createState() => _AlmacenScreenState();
}

class _AlmacenScreenState extends State<AlmacenScreen> {
  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;
    // Carga el widget ListadoPedidos que está en el archivo Widgets
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        heroTag: 1,
        onPressed: () {
          ManejadorEstatico.LanzarActividad(
              context,
              EditorAlmacenScreen(
                  articulo:
                Articulo(articulo: '', observaciones: '', url: '')));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_rounded),
      ),
      backgroundColor: Colors.white,
      // Barra superior
      appBar: AppBar(
        title: Text(RecursosEstaticos.articuloLabel),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  AlertDialog alert = RecursosEstaticos.alertDialogLoading;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  final response = await ManejadorEstatico.getRequest('almacen');
                  setState(() {
                    widget.articulos = List<Articulo>.from(
                        json.decode(response.body).map((x) => Articulo.fromJson(x)));
                  });
                  Navigator.pop(context, true);
                },
                child: Icon(Icons.wifi_protected_setup_rounded),
              )),
        ],
      ),
      // Columna principal que sustenta los elementos del widget
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Primer elemento de la columna, el TextFormField para filtrar
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: RecursosEstaticos.filtradoLabel,
              ),
              controller: widget._busquedaController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          // Segundo elemento de la columna, la fila de botones
          SizedBox(
            width: width,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /**
                 * Botones de la fila para filtrar
                 */
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._orderbyNom = !widget._orderbyNom;
                      widget._orderbyCant = false;
                      widget._orderbyPrecio = false;
                      widget._orderbyObs = false;

                      if (widget._orderbyNom) {
                        widget.articulos.sort((a, b) =>
                            a.articulo.toString().compareTo(b.articulo.toString()));
                      } else {
                        widget.articulos.sort((a, b) =>
                            b.articulo.toString().compareTo(a.articulo.toString()));
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    margin: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                    width: width * 0.25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nombre',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyNom
                            ? Transform.scale(
                          scaleY: -1,
                          child: const Icon(Icons.sort_rounded),
                        )
                            : const Icon(Icons.sort_rounded),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._orderbyNom = false;
                      widget._orderbyCant = !widget._orderbyCant;
                      widget._orderbyPrecio = false;
                      widget._orderbyObs = false;

                      if (widget._orderbyCant) {
                        widget.articulos
                            .sort((a, b) => a.cantidad.compareTo(b.cantidad));
                      } else {
                        widget.articulos
                            .sort((a, b) => b.cantidad.compareTo(a.cantidad));
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ]),
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    width: width * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cantidad',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyCant
                            ? Transform.scale(
                          scaleY: -1,
                          child: const Icon(Icons.sort_rounded),
                        )
                            : const Icon(Icons.sort_rounded),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget._orderbyNom = false;
                      widget._orderbyCant = false;
                      widget._orderbyPrecio = !widget._orderbyPrecio;
                      widget._orderbyObs = false;
                      if (widget._orderbyPrecio) {
                        widget.articulos
                            .sort((a, b) => a.precio.compareTo(b.precio));
                      } else {
                        widget.articulos
                            .sort((a, b) => b.precio.compareTo(a.precio));
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    width: width * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Precio',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyPrecio
                            ? Transform.scale(
                          scaleY: -1,
                          child: const Icon(Icons.sort_rounded),
                        )
                            : const Icon(Icons.sort_rounded),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget._orderbyNom = false;
                        widget._orderbyCant = false;
                        widget._orderbyPrecio = false;
                        widget._orderbyObs = !widget._orderbyObs;
                        if (widget._orderbyObs) {
                          widget.articulos.sort((a, b) {
                            a.observaciones ??= '';
                            b.observaciones ??= '';
                            return a.observaciones.compareTo(b.observaciones);
                          });
                        } else {
                          widget.articulos.sort((a, b) {
                            a.observaciones ??= '';
                            b.observaciones ??= '';
                            return b.observaciones.compareTo(a.observaciones);
                          });
                        }
                      });
                    },
                    child: Container(
                      width: RecursosEstaticos.isPCPlatform
                          ? width * 0.53
                          : width * 0.35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                      //width: width * 0.10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Observaciones',
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                          widget._orderbyObs
                              ? Transform.scale(
                            scaleY: -1,
                            child: const Icon(Icons.sort_rounded),
                          )
                              : const Icon(Icons.sort_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tercer elemento de la columna, una lista scrolleable con los registros
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListViewBuilder(
                    1,
                    articulos: widget._busquedaController.text.isEmpty
                        ? widget.articulos
                        : widget.articulos != null
                        ? widget.articulos.where((articulo) {
                      return articulo.articulo
                          .toString()
                          .toLowerCase()
                          .contains(widget
                          ._busquedaController.text
                          .toLowerCase()) ||
                          articulo.cantidad.toString().toLowerCase().contains(widget
                              ._busquedaController.text
                              .toLowerCase()) ||
                          articulo.precio.toString().toLowerCase().contains(
                              widget._busquedaController.text
                                  .toLowerCase()) ||
                          articulo.observaciones
                              .toString()
                              .toLowerCase()
                              .contains(widget
                              ._busquedaController.text
                              .toLowerCase());
                    }).toList()
                        : widget.articulos,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
