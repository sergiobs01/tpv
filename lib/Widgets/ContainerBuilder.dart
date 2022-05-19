import 'package:flutter/material.dart';
import 'package:tpv/Actividades/EditorAlmacenScreen.dart';
import 'package:tpv/Actividades/EditorClienteScreen.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';

import '../Clases/Articulo.dart';
import '../Clases/Cliente.dart';
import '../Recursos/RecursosEstaticos.dart';

class ContainerBuilder extends StatelessWidget {
  final width;
  final Cliente cliente;
  final Articulo articulo;
  final esPar;
  final tipo;
  final bool crearDescuento;

  ContainerBuilder(this.width,
      {this.esPar,
      this.tipo,
      this.articulo,
      this.cliente,
      this.crearDescuento});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Pinta un registro en gris dependiendo de si es par o impar (para mejorar la usabilidad)
      decoration: BoxDecoration(color: esPar ? Colors.grey : Colors.white),
      width: width,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 5),
      // Contiene una fila que mostrará los distintos campos de un mismo registro en SizedBoxes
      child: GestureDetector(
        // AÑADE LA FUNCION EN EL CLICK DEL CLIENTE O PEDIDO
        onTap: () {
          //print("prueba");
          switch (tipo) {
            case 0:
              // LANZA ACTIVIDAD DE NUEVO PEDIDO
              break;
            case 1:
              // LANZA ACTIVIDAD DE VER ARTICULOS
              ManejadorEstatico.LanzarActividad(
                  context, EditorAlmacenScreen(articulo: articulo));
              break;
            case 2:
              // LANZA ACTIVIDAD DE VER CLIENTES
              if (crearDescuento) {
              } else {
                ManejadorEstatico.LanzarActividad(
                    context, EditorClienteScreen(cliente: cliente));
              }
              break;
            case 3:
              // LANZA ACTIVIDAD DE VER DESCUENTOS

              break;
            case 4:
              break;
            case 5:
              break;
          }
        },
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /**
             * SizedBozes con sus textos y tamaños
             */
            tipo == 0
                ? Container()
                : tipo == 1
                    ? SizedBox(
                        child: Text(
                          articulo.articulo ?? '',
                          style: const TextStyle(fontSize: 12),
                        ),
                        width: width * 0.251,
                      )
                    : tipo == 2
                        ? SizedBox(
                            child: Text(
                              cliente.id != null ? cliente.id.toString() : '',
                              style: const TextStyle(fontSize: 12),
                            ),
                            width: RecursosEstaticos.isPCPlatform
                                ? width * 0.12
                                : width * 0.13,
                          )
                        : tipo == 3
                            ? Container()
                            : tipo == 4
                                ? Container()
                                : tipo == 5
                                    ? Container()
                                    : Container(),
            tipo == 0
                ? const Expanded(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                : tipo == 1
                    ? SizedBox(
                        child: Text(
                          articulo.cantidad.toString(),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: width * 0.108,
                      )
                    : tipo == 2
                        ? SizedBox(
                            child: Text(
                              cliente.nombre ?? '',
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            width: RecursosEstaticos.isPCPlatform
                                ? width * 0.2035
                                : width * 0.21,
                          )
                        : tipo == 3
                            ? Container()
                            : tipo == 4
                                ? Container()
                                : tipo == 5
                                    ? Container()
                                    : Container(),
            tipo == 0
                ? Container()
                : tipo == 1
                    ? SizedBox(
                        child: Text(
                          articulo.precio.toString(),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: width * 0.1,
                      )
                    : tipo == 2
                        ? SizedBox(
                            child: Text(
                              cliente.apellidos ?? '',
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            width: width * 0.271,
                          )
                        : tipo == 3
                            ? Container()
                            : tipo == 4
                                ? Container()
                                : tipo == 5
                                    ? Container()
                                    : Container(),
            tipo == 0
                ? Container()
                : tipo == 1
                    ? SizedBox(
                        child: Text(
                          articulo.observaciones ?? '',
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    : tipo == 2
                        ? SizedBox(
                            child: Text(
                              cliente.email ?? '',
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : tipo == 3
                            ? Container()
                            : tipo == 4
                                ? Container()
                                : tipo == 5
                                    ? Container()
                                    : Container(),
          ],
        ),
      ),
    );
  }
}
