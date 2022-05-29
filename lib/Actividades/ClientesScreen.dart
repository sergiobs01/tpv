import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpv/Clases/Cliente.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

import '../Widgets/ListViewBuilder.dart';
import 'EditorClienteScreen.dart';

class ClientesScreen extends StatefulWidget {
  final _busquedaController = TextEditingController();
  List<Cliente> clientes;

  bool _orderbyCod = false;
  bool _orderbyNom = false;
  bool _orderbyApellido = false;
  bool _orderbyEmail = false;
  bool crearDescuento;

  ClientesScreen({this.clientes, this.crearDescuento});

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;
    // Carga el widget ListadoPedidos que está en el archivo Widgets
    return Scaffold(
      floatingActionButton: !widget.crearDescuento
          ? FloatingActionButton(
        heroTag: 1,
              onPressed: () {
                ManejadorEstatico.LanzarActividad(
                    context,
                    EditorClienteScreen(
                        cliente:
                            Cliente(nombre: '', apellidos: '', email: '')));
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add_rounded),
            )
          : Container(),
      backgroundColor: Colors.white,
      // Barra superior
      appBar: AppBar(
        title: Text(RecursosEstaticos.clientesLabel),
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
                  final response = await ManejadorEstatico.getRequest('cliente');
                  setState(() {
                    widget.clientes = List<Cliente>.from(
                        json.decode(response.body).map((x) => Cliente.fromJson(x)));
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
                      widget._orderbyCod = !widget._orderbyCod;
                      widget._orderbyNom = false;
                      widget._orderbyApellido = false;
                      widget._orderbyEmail = false;

                      if (widget._orderbyCod) {
                        widget.clientes.sort((a, b) =>
                            a.id.toString().compareTo(b.id.toString()));
                      } else {
                        widget.clientes.sort((a, b) =>
                            b.id.toString().compareTo(a.id.toString()));
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
                    width: width * 0.12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ID',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyCod
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
                      widget._orderbyCod = false;
                      widget._orderbyNom = !widget._orderbyNom;
                      widget._orderbyApellido = false;
                      widget._orderbyEmail = false;

                      if (widget._orderbyNom) {
                        widget.clientes
                            .sort((a, b) => a.nombre.compareTo(b.nombre));
                      } else {
                        widget.clientes
                            .sort((a, b) => b.nombre.compareTo(a.nombre));
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
                    width: width * 0.20,
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
                      widget._orderbyCod = false;
                      widget._orderbyNom = false;
                      widget._orderbyApellido = !widget._orderbyApellido;
                      widget._orderbyEmail = false;
                      if (widget._orderbyApellido) {
                        widget.clientes
                            .sort((a, b) => a.apellidos.compareTo(b.apellidos));
                      } else {
                        widget.clientes
                            .sort((a, b) => b.apellidos.compareTo(a.apellidos));
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
                    width: width * 0.264,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Apellidos',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyApellido
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
                        widget._orderbyCod = false;
                        widget._orderbyNom = false;
                        widget._orderbyApellido = false;
                        widget._orderbyEmail = !widget._orderbyEmail;
                        if (widget._orderbyEmail) {
                          widget.clientes.sort((a, b) {
                            a.email ??= '';
                            b.email ??= '';
                            return a.email.compareTo(b.email);
                          });
                        } else {
                          widget.clientes.sort((a, b) {
                            a.email ??= '';
                            b.email ??= '';
                            return b.email.compareTo(a.email);
                          });
                        }
                      });
                    },
                    child: Container(
                      width: RecursosEstaticos.isPCPlatform
                          ? width * 0.395
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
                            'Email',
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                          widget._orderbyEmail
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
                    2,
                    clientes: widget._busquedaController.text.isEmpty
                        ? widget.clientes
                        : widget.clientes != null
                            ? widget.clientes.where((cliente) {
                                return cliente.id
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase()) ||
                                    cliente.nombre.toLowerCase().contains(widget
                                        ._busquedaController.text
                                        .toLowerCase()) ||
                                    cliente.apellidos.toLowerCase().contains(
                                        widget._busquedaController.text
                                            .toLowerCase()) ||
                                    cliente.email
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase());
                              }).toList()
                            : widget.clientes,
                    crearDescuento: widget.crearDescuento,
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
