import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpv/Socket/SocketClient.dart';

import '../Clases/Articulo.dart';
import '../Clases/Mesa.dart';
import '../Recursos/RecursosEstaticos.dart';

class ListaPedidosMovilScreen extends StatefulWidget {
  Mesa mesa;
  List<Articulo> articulos;
  double total = 0;

  ListaPedidosMovilScreen({this.mesa, this.articulos});

  @override
  State<ListaPedidosMovilScreen> createState() =>
      _ListaPedidosMovilScreenState();
}

class _ListaPedidosMovilScreenState extends State<ListaPedidosMovilScreen> {
  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;

    widget.total = 0;
    widget.mesa.articulos
        .map((e) => (widget.total += e.cantidad * e.precio))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(RecursosEstaticos.listapedidos + widget.mesa.nombre),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: size.height * 0.45,
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                  margin: const EdgeInsets.only(right: 30, left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Articulo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Precio',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'Cantidad',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: width,
                    height: size.height * 0.3,
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric( horizontal: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 130,
                                  child: Text(
                                    widget.mesa.articulos[index].articulo,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: SizedBox(
                                    child: Text(widget
                                            .mesa.articulos[index].precio
                                            .toStringAsFixed(2) +
                                        ' €'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          setState(() {
                                            widget.mesa.articulos[index]
                                                .cantidad--;
                                            if (widget.mesa.articulos[index]
                                                    .cantidad ==
                                                0) {
                                              widget.mesa.articulos.remove(
                                                  widget.mesa.articulos[index]);
                                            }
                                          });
                                        });
                                      },
                                      child: Container(
                                        child: const Text('-'),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        height: 25,
                                        width: 25,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    Text(widget.mesa.articulos[index].cantidad
                                        .toString()),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (widget.mesa.articulos[index]
                                                  .cantidad <
                                              widget.articulos
                                                  .elementAt(widget.articulos
                                                      .indexOf(widget.mesa
                                                          .articulos[index]))
                                                  .cantidad) {
                                            widget.mesa.articulos[index]
                                                .cantidad++;
                                          } else {
                                            AlertDialog alert = AlertDialog(
                                              content: const Text(
                                                  'La cantidad supera al almacen'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child:
                                                        const Text('Aceptar'))
                                              ],
                                            );
                                            showDialog(
                                                context: context,
                                                builder: (context) => alert);
                                          }
                                        });
                                      },
                                      child: Container(
                                        child: const Text('+'),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        height: 25,
                                        width: 25,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: widget.mesa.articulos.length,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(bottom: 10, right: 30),
                  child: Text(
                    'Total: ' + widget.total.toStringAsFixed(2) + ' €',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: width * 0.9,
            height: size.height * 0.3,
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                )),
            child: GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 120,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              children: widget.articulos
                  .map((e) => InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            if (widget.mesa.articulos.contains(e)) {
                              if (widget.mesa.articulos
                                      .elementAt(
                                          widget.mesa.articulos.indexOf(e))
                                      .cantidad <
                                  widget.articulos
                                      .elementAt(widget.articulos.indexOf(widget
                                          .mesa.articulos
                                          .elementAt(widget.mesa.articulos
                                              .indexOf(e))))
                                      .cantidad) {
                                widget.mesa.articulos
                                    .elementAt(widget.mesa.articulos.indexOf(e))
                                    .cantidad++;
                              } else {
                                AlertDialog alert = AlertDialog(
                                  content: const Text(
                                      'La cantidad supera al almacen'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Aceptar'))
                                  ],
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => alert);
                              }
                            } else {
                              if (e.cantidad == 0) {
                                AlertDialog alert = AlertDialog(
                                  content:
                                      const Text('No hay stock en el almacen'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Aceptar'))
                                  ],
                                );
                                showDialog(
                                    context: context,
                                    builder: (context) => alert);
                              } else {
                                widget.mesa.articulos.add(Articulo(
                                    id: e.id,
                                    precio: e.precio,
                                    cantidad: 1,
                                    articulo: e.articulo));
                              }
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Text(
                                e.articulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                e.articulo,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.3
                                    ..color = Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(e.url),
                            ),
                            color: Colors.blue,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withOpacity(0.7),
                                Colors.blue,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, right: 20),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                    content:
                        const Text('¿Desea enviar el pedido al ordenador?'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (builder) =>
                                    RecursosEstaticos.alertDialogLoading);
                            await sendMessage(
                                json.encode(widget.mesa.toJson()));
                            Navigator.pop(context);
                            AlertDialog alert = AlertDialog(
                              content: const Text('Pedido enviado'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Aceptar')),
                              ],
                            );
                            showDialog(context: context, builder: (builder)=>alert);
                          },
                          child: Text('Aceptar')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar')),
                    ],
                  );
                  showDialog(context: context, builder: (context) => alert);
                },
                child: const Text('Enviar')),
          )
        ],
      ),
    );
  }
}
