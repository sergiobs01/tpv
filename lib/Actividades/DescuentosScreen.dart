import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Clases/Descuento.dart';

import '../Clases/Cliente.dart';
import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/ListViewBuilder.dart';

class DescuentosScreen extends StatefulWidget {
  final _busquedaController = TextEditingController();
  List<Descuento> descuentos;

  bool _orderbyClientNom = false;
  bool _orderbyCant = false;

  DescuentosScreen({@required this.descuentos});

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
        onPressed: () async {
          AlertDialog alert = RecursosEstaticos.alertDialogLoading;
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          final response = await ManejadorEstatico.getRequest('cliente');
          List<Cliente> clientes = List<Cliente>.from(
              json.decode(response.body).map((x) => Cliente.fromJson(x)));
          ManejadorEstatico.LanzarActividad(
              context,
              ClientesScreen(
                clientes: clientes,
                crearDescuento: true,
              ));
          Navigator.pop(context, true);
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
                  AlertDialog alert = RecursosEstaticos.alertDialogLoading;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                  Response response =
                      await ManejadorEstatico.getRequest('descuento');
                  List<Descuento> descuentos = List<Descuento>.from(
                      json.decode(response.body).map((x) => Descuento.fromJson(x)));
                  response = await ManejadorEstatico.getRequest('cliente');
                  List<Cliente> clientes = List<Cliente>.from(
                      json.decode(response.body).map((x) => Cliente.fromJson(x)));
                  setState(() {
                    widget.descuentos = descuentos.where((descuento) {
                      clientes.where((cliente) {
                        if (descuento.clienteId == cliente.id) {
                          descuento.clienteNom =
                              cliente.nombre + ' ' + cliente.apellidos;
                        }
                        return true;
                      }).toList();
                      return true;
                    }).toList();
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
          Expanded(
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  ListViewBuilder(
                    3,
                    descuentos: widget._busquedaController.text.isEmpty
                        ? widget.descuentos
                        : widget.descuentos != null
                            ? widget.descuentos.where((descuento) {
                                return descuento.clienteNom
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase()) ||
                                    descuento.cantidad
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase());
                              }).toList()
                            : widget.descuentos,
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
