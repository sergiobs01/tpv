import 'package:flutter/material.dart';
import 'package:tpv/Clases/Articulo.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';
import 'package:tpv/Widgets/ListViewBuilder.dart';

import '../Clases/Mesa.dart';

class ListaPedidosPCScreen extends StatefulWidget {
  Mesa mesa;
  List<Articulo> articulos;

  ListaPedidosPCScreen({@required this.mesa});

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
    return Scaffold(
      appBar: AppBar(
        title: Text(RecursosEstaticos.listapedidos),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: width * 0.4,
                height: size.height * 0.9,
                child: ListView.builder(
                  itemBuilder: (xdxd, xdxdx) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            child: Text('Hola', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  child: const Text('+'),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  height: 25,
                                  width: 25,
                                  alignment: Alignment.center,
                                ),
                              ),
                              Text('1'),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  child: const Text('-'),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                  itemCount: 20,
                ),
              ),
            ),
          ),
          /*ListViewBuilder(
            5,
            mesa: widget.mesa,
          ),*/
          Column(
            children: [Text('Hola'), Text('hola')],
          )
        ],
      ),
    );
  }
}
