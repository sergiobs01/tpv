import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tpv/Actividades/DetallesPedidoScreen.dart';
import 'package:tpv/Actividades/EditorAlmacenScreen.dart';
import 'package:tpv/Actividades/EditorClienteScreen.dart';
import 'package:tpv/Actividades/EditorDescuentoScreen.dart';
import 'package:tpv/Actividades/EditorMesasScreen.dart';
import 'package:tpv/Clases/Descuento.dart';
import 'package:tpv/Clases/Mesa.dart';
import 'package:tpv/Recursos/ManejadorEstatico.dart';

import '../Clases/Articulo.dart';
import '../Clases/Cliente.dart';
import '../Recursos/RecursosEstaticos.dart';

class ContainerBuilder extends StatelessWidget {
  final width;
  final Cliente cliente;
  final Articulo articulo;
  final Descuento descuento;
  final Mesa mesa;
  final esPar;
  final tipo;
  final bool crearDescuento;
  final bool finalizarVenta;
  final bool tarjeta;

  ContainerBuilder(
    this.width, {
    this.esPar,
    this.tipo,
    this.articulo,
    this.cliente,
    this.descuento,
    this.crearDescuento,
    this.mesa,
    this.finalizarVenta,
    this.tarjeta,
  });

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
        onTap: () async {
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
              if (finalizarVenta) {
                // Buscar descuentos
                // Llevo mesa
                AlertDialog alert;
                showDialog(
                    context: context,
                    builder: (context) => RecursosEstaticos.alertDialogLoading);
                Response response = await ManejadorEstatico.getRequest(
                    'descuento',
                    id: cliente.id);
                List<Descuento> descuentos = List<Descuento>.from(json
                    .decode(response.body)
                    .map((x) => Descuento.fromJson(x)));
                Navigator.pop(context);
                if (descuentos.isNotEmpty) {
                  alert = AlertDialog(
                    content: const Text(
                        'Hay descuentos asociados al cliente, ¿desea usarlos?'),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            //Cargar pantalla pedido
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    RecursosEstaticos.alertDialogLoading);

                            Response response =
                                await ManejadorEstatico.getRequest('almacen');
                            List<Articulo> articulos = List<Articulo>.from(json
                                .decode(response.body)
                                .map((x) => Articulo.fromJson(x)));

                            for (Descuento c in descuentos) {
                              await ManejadorEstatico.deleteRequest(
                                  'descuento', c.id);
                            }

                            for (Articulo a in mesa.articulos) {
                              await ManejadorEstatico.postRequest('venta', {
                                'usuario': RecursosEstaticos.usuario.usuario,
                                'cliente_id': cliente.id,
                                'articulo_id': a.id,
                                'mesa_id': mesa.id,
                                'cantidad': a.cantidad,
                                'dia_venta': DateTime.now().toString(),
                                'observaciones': tarjeta
                                    ? 'Pago con tarjeta'
                                    : 'Pago en efectivo',
                              });

                              await ManejadorEstatico.putRequest('almacen', {
                                'id': a.id,
                                'articulo': articulos
                                    .elementAt(articulos.indexOf(a))
                                    .articulo,
                                'cantidad': articulos
                                        .elementAt(articulos.indexOf(a))
                                        .cantidad -
                                    a.cantidad,
                                'precio': articulos
                                    .elementAt(articulos.indexOf(a))
                                    .precio,
                                'url': articulos
                                    .elementAt(articulos.indexOf(a))
                                    .url,
                                'observaciones': articulos
                                    .elementAt(articulos.indexOf(a))
                                    .observaciones,
                              });
                            }

                            Navigator.pop(context, true);

                            ManejadorEstatico.LanzarActividad(
                                context,
                                DetallesPedidoScreen(
                                  mesa: mesa,
                                  tarjeta: tarjeta,
                                  descuentos: descuentos,
                                ));
                          },
                          child: const Text('Aceptar')),
                      TextButton(
                          onPressed: () {
                            //Cargar pantalla pedido
                            Navigator.pop(context);
                            ManejadorEstatico.LanzarActividad(
                                context,
                                DetallesPedidoScreen(
                                  mesa: mesa,
                                  tarjeta: tarjeta,
                                  descuentos: [],
                                ));
                          },
                          child: const Text('Cancelar')),
                    ],
                  );
                  showDialog(context: context, builder: (context) => alert);
                } else {
                  // Cargar pantalla pedido
                  ManejadorEstatico.LanzarActividad(
                      context,
                      DetallesPedidoScreen(
                        mesa: mesa,
                        tarjeta: tarjeta,
                        descuentos: [],
                      ));
                }
                print(descuentos.length);
              } else {
                if (crearDescuento) {
                  ManejadorEstatico.LanzarActividad(
                      context,
                      EditorDescuentoScreen(
                          descuento: Descuento(clienteId: cliente.id),
                          btnAbierto: false));
                } else {
                  ManejadorEstatico.LanzarActividad(
                      context, EditorClienteScreen(cliente: cliente));
                }
              }
              break;
            case 3:
              // LANZA ACTIVIDAD DE VER DESCUENTOS
              ManejadorEstatico.LanzarActividad(
                  context,
                  EditorDescuentoScreen(
                      descuento: descuento, btnAbierto: false));
              break;
            case 4:
              // LANZA ACTIVIDAD DE VER MESA
              ManejadorEstatico.LanzarActividad(
                  context, EditorMesasScreen(mesa: mesa, btnAbierto: false));
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
                            ? SizedBox(
                                child: Text(
                                  descuento.id.toString() +
                                      ' - ' +
                                      (descuento.clienteNom ??
                                          'CLIENTE SIN NOMBRE'),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                width: width * 0.8,
                              )
                            : tipo == 4
                                ? SizedBox(
                                    child: Text(
                                      mesa.id.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    width: width * 0.187,
                                  )
                                : tipo == 5
                                    ? SizedBox(
                                        child: Text(
                                          articulo.articulo,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        width: width * 0.187,
                                      )
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
                            ? SizedBox(
                                child: Text(
                                  descuento.cantidad != null
                                      ? descuento.cantidad.toString()
                                      : '',
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : tipo == 4
                                ? SizedBox(
                                    child: Text(
                                      mesa.nombre ?? '',
                                      style: const TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                : tipo == 5
                                    ? Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('+')),
                                          Text(articulo.cantidad.toString()),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('-')),
                                        ],
                                      )
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
