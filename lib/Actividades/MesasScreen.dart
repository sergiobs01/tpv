import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Actividades/EditorMesasScreen.dart';
import 'package:tpv/Clases/Mesa.dart';

import '../Clases/Cliente.dart';
import '../Recursos/ManejadorEstatico.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/ListViewBuilder.dart';

class MesasScreen extends StatefulWidget {
  final _busquedaController = TextEditingController();
  List<Mesa> mesas;

  bool _orderbyId = false;
  bool _orderbyNombre = false;

  MesasScreen({@required this.mesas});

  @override
  State<MesasScreen> createState() => _MesasScreenState();
}

class _MesasScreenState extends State<MesasScreen> {
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
              context, EditorMesasScreen(mesa: Mesa(), btnAbierto: false));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_rounded),
      ),
      backgroundColor: Colors.white,
      // Barra superior
      appBar: AppBar(
        title: Text(RecursosEstaticos.mesasLabel),
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
                      await ManejadorEstatico.getRequest('mesas');
                  setState(() {
                    widget.mesas = List<Mesa>.from(json
                        .decode(
                            response.body.replaceAll('}', ',"articulos":[]}'))
                        .map((x) => Mesa.fromJson(x)));
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
                      widget._orderbyId = !widget._orderbyId;
                      widget._orderbyNombre = false;

                      if (widget._orderbyId) {
                        widget.mesas.sort((a, b) =>
                            a.id.toString().compareTo(b.id.toString()));
                      } else {
                        widget.mesas.sort((a, b) =>
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
                    width: width * 0.187,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ID de mesa',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyId
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
                      widget._orderbyId = false;
                      widget._orderbyNombre = !widget._orderbyNombre;

                      if (widget._orderbyNombre) {
                        widget.mesas
                            .sort((a, b) => a.nombre.compareTo(b.nombre));
                      } else {
                        widget.mesas
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
                    width: width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nombre',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                        widget._orderbyNombre
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
                    4,
                    mesas: widget._busquedaController.text.isEmpty
                        ? widget.mesas
                        : widget.mesas != null
                            ? widget.mesas.where((mesa) {
                                return mesa.id
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase()) ||
                                    mesa.nombre
                                        .toString()
                                        .toLowerCase()
                                        .contains(widget
                                            ._busquedaController.text
                                            .toLowerCase());
                              }).toList()
                            : widget.mesas,
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
