import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpv/Clases/Descuento.dart';

import '../Clases/Mesa.dart';
import '../Recursos/RecursosEstaticos.dart';
import '../Widgets/Delimitadores.dart';

class DetallesPedidoScreen extends StatelessWidget {
  Mesa mesa;
  bool tarjeta;
  List<Descuento> descuentos;
  double total = 0;

  DetallesPedidoScreen({
    this.mesa,
    this.tarjeta,
    this.descuentos,
  });

  @override
  Widget build(BuildContext context) {
    total = 0;
    mesa.articulos.map((e) => total += e.cantidad * e.precio).toList();
    descuentos.map((e) => total = total - total * e.cantidad/100).toList();
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del pedido'),
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pedido realizado a las ' +
                    DateFormat.Hm().format(DateTime.now()),
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Detalles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              width: width - 50,
              height: size.height * 0.72,
              decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.05),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mesa.articulos
                          .map((e) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  e.articulo +
                                      ' - ' +
                                      e.cantidad.toString() +
                                      'x' +
                                      e.precio.toStringAsFixed(2) +
                                      ' = ' +
                                      (e.precio * e.cantidad)
                                          .toStringAsFixed(2) +
                                      ' €',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ))
                          .toList(),
                    ),
                    Space(),
                    descuentos.isNotEmpty
                        ? const Text(
                            'Descuentos',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )
                        : Container(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: descuentos
                          .map((e) => Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  e.cantidad.toStringAsFixed(2) + ' %',
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ))
                          .toList(),
                    ),
                    descuentos.isNotEmpty ? Space() : Container(),
                    Text(
                      'Forma de pago: ' + (tarjeta ? 'Tarjeta' : 'Efectivo'),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Space(),
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        total.toStringAsFixed(2) + ' €',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25),
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 170,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    RecursosEstaticos.pedidos[mesa.id].articulos = [];
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Volver al menú',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
