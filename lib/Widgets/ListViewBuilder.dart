import 'package:flutter/material.dart';
import 'package:tpv/Clases/Articulo.dart';

import '../Clases/Cliente.dart';
import '../Clases/Descuento.dart';
import 'ContainerBuilder.dart';

/// List view con parametros genericos
class ListViewBuilder extends StatelessWidget {
  final tipo;
  final List<Cliente> clientes;
  final List<Articulo> articulos;
  final bool crearDescuento;
  final List<Descuento> descuentos;

  ListViewBuilder(this.tipo, {this.articulos, this.clientes, this.crearDescuento, this.descuentos});

  @override
  Widget build(BuildContext context) {
    // Se coge el tamaño de la pantalla para hacerlo responsive
    var size = MediaQuery.of(context).size;
    // Ancho de la pantalla
    var width = size.width;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // Mostrará tantos items como registros haya devuelto la consulta
      itemCount: tipo == 0
          ? 0
          : tipo == 1
              ? articulos.length
              : tipo == 2
                  ? clientes.length
                  : tipo == 3
                      ? descuentos.length
                      : tipo == 4
                          ? 0
                          : tipo == 5
                              ? 0
                              : 0,
      itemBuilder: (context, index) {
        // Si la posición del registro es par, se mostrará con fondo blanco
        switch (tipo) {
          case 0:
            break;
          case 1:
            return ContainerBuilder(
              width,
              articulo: articulos[index],
              esPar: index % 2 == 0,
              tipo: tipo,
            );
            break;
          case 2:
            return ContainerBuilder(
              width,
              cliente: clientes[index],
              esPar: index % 2 == 0,
              tipo: tipo,
              crearDescuento: crearDescuento,
            );
            break;
          case 3:
            return ContainerBuilder(
              width,
              descuento: descuentos[index],
              esPar: index % 2 == 0,
              tipo: tipo,
            );
            break;
          case 4:
            break;
          case 5:
            break;
        }
        return Text("ERROR");
      },
    );
  }
}
