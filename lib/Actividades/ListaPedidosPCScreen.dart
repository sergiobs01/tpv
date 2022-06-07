import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/ClientesScreen.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Widgets/ListViewBuilder.dart';

import '../Clases/Cliente.dart';
import '../Clases/Mesa.dart';
import '../Recursos/ManejadorEstatico.dart';

class ListaPedidosPCScreen extends StatefulWidget {
  Mesa mesa;
  List<Articulo> articulos;
  double total = 0;

  ListaPedidosPCScreen({@required this.mesa, @required this.articulos});

  @override
  State<ListaPedidosPCScreen> createState() => _ListaPedidosPCScreenState();
}

class _ListaPedidosPCScreenState extends State<ListaPedidosPCScreen> {
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
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width * 0.45,
            height: size.height,
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
                    children: [
                      const Text(
                        'Articulo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Text(
                          'Precio',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const Text(
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
                    width: width * 0.45,
                    height: size.height * 0.8,
                    child: SizedBox(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    widget.mesa.articulos[index].articulo,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(widget
                                          .mesa.articulos[index].precio
                                          .toStringAsFixed(2) +
                                      ' €'),
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
          /*ListViewBuilder(
            5,
            mesa: widget.mesa,
          ),*/
          Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            width: width * 0.53,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.75,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      )),
                  child: GridView(
                    padding: const EdgeInsets.all(15),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 40,
                      mainAxisSpacing: 40,
                    ),
                    children: widget.articulos
                        .map((e) => InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                setState(() {
                                  if (widget.mesa.articulos.contains(e)) {
                                    if (widget.mesa.articulos
                                            .elementAt(widget.mesa.articulos
                                                .indexOf(e))
                                            .cantidad <
                                        widget.articulos
                                            .elementAt(widget.articulos.indexOf(
                                                widget.mesa.articulos.elementAt(
                                                    widget.mesa.articulos
                                                        .indexOf(e))))
                                            .cantidad) {
                                      widget.mesa.articulos
                                          .elementAt(
                                              widget.mesa.articulos.indexOf(e))
                                          .cantidad++;
                                    } else {
                                      AlertDialog alert = AlertDialog(
                                        content: const Text(
                                            'La cantidad supera al almacen'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                                        content: const Text(
                                            'No hay stock en el almacen'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
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
                                        fontSize: 18,
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
                                        fontSize: 18,
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
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: size.height * 0.15,
                        width: width * 0.25,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (widget.mesa.articulos.isNotEmpty) {
                              AlertDialog alert = AlertDialog(
                                content: const Text(
                                    'Va a proceder a seleccionar un cliente, ¿desea continuar?'),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        AlertDialog alert = RecursosEstaticos
                                            .alertDialogLoading;
                                        showDialog(
                                            context: context,
                                            builder: (context) => alert);
                                        Response response =
                                            await ManejadorEstatico.getRequest(
                                                'cliente');
                                        List<Cliente> clientes =
                                            List<Cliente>.from(json
                                                .decode(response.body)
                                                .map((x) =>
                                                    Cliente.fromJson(x)));
                                        Navigator.pop(context);
                                        ManejadorEstatico.LanzarActividad(
                                            context,
                                            ClientesScreen(
                                                clientes: clientes,
                                                crearDescuento: false,
                                                finalizarVenta: true,
                                                tarjeta: true,
                                                mesa: widget.mesa));
                                      },
                                      child: const Text('Aceptar')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancelar')),
                                ],
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) => alert);
                            } else {
                              AlertDialog alert = AlertDialog(
                                content:
                                    const Text('No hay productos que facturar'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Aceptar')),
                                ],
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) => alert);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                const Text(
                                  'Tarjeta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                                Text(
                                  'Tarjeta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1.5
                                      ..color = Colors.black,
                                    fontSize: 26,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/128/62/62780.png'),
                              ),
                              color: Colors.greenAccent.shade100,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade200,
                                  Colors.blue.shade200.withOpacity(0.7),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15, left: 57),
                        height: size.height * 0.15,
                        width: width * 0.25,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                const Text(
                                  'Efectivo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 26,
                                  ),
                                ),
                                Text(
                                  'Efectivo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1.5
                                      ..color = Colors.black,
                                    fontSize: 26,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/128/2488/2488749.png'),
                              ),
                              color: Colors.greenAccent.shade100,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade200.withOpacity(0.7),
                                  Colors.blue.shade200,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
