import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Clases/Descuento.dart';

import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';

class DescuentosScreen extends StatefulWidget {
  final _busquedaController = TextEditingController();
  List<Descuento> descuentos;

  bool _orderbyClientNom = false;
  bool _orderbyCant = false;

  DescuentosScreen({this.descuentos});

  @override
  State<DescuentosScreen> createState() => _DescuentosScreenState();
}

class _DescuentosScreenState extends State<DescuentosScreen> {
  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;
    // Carga el widget ListadoPedidos que está en el archivo Widgets
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 1,
        onPressed: () {
          ManejadorEstatico.LanzarActividad(
              context,
              ClientesScreen(
                clientes: [],
                crearDescuento: true,
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_rounded),
      ),
      backgroundColor: Colors.white,
      // Barra superior
      appBar: AppBar(
        title: Text(RecursosEstaticos.descuentoLabel),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  AlertDialog alert = AlertDialog(
                    content: Container(
                      //width: 80,
                      //height: 50,
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            const CircularProgressIndicator(),
                            Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: const Text('Cargando...')),
                          ],
                        ),
                      ),
                    ),
                  );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  final response =
                      await ManejadorEstatico.getRequest('descuento');
                  setState(() {
                    widget.descuentos = List<Descuento>.from(json
                        .decode(response.body)
                        .map((x) => Descuento.fromJson(x)));
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
                      widget._orderbyClientNom = !widget._orderbyClientNom;
                      widget._orderbyCant = false;

                      if (widget._orderbyClientNom) {
                        widget.descuentos.sort((a, b) => a.clienteNom
                            .toString()
                            .compareTo(b.clienteNom.toString()));
                      } else {
                        widget.descuentos.sort((a, b) => b.clienteNom
                            .toString()
                            .compareTo(a.clienteNom.toString()));
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
                    width: width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nombre de cliente',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyClientNom
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
                      widget._orderbyClientNom = false;
                      widget._orderbyCant = !widget._orderbyCant;

                      if (widget._orderbyCant) {
                        widget.descuentos
                            .sort((a, b) => a.cantidad.compareTo(b.cantidad));
                      } else {
                        widget.descuentos
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
                    width: width * 0.187,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cantidad (%)',
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
              ],
            ),
          ),
          // Tercer elemento de la columna, una lista scrolleable con los registros
          /*Expanded(
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
                                    articulo.cantidad
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase()) ||
                                    articulo.precio
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
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
          ),*/
        ],
      ),
    );
  }
}
