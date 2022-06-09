import 'package:flutter/material.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

class AyudaScreen extends StatefulWidget {
  int caso = 0;

  @override
  State<AyudaScreen> createState() => _AyudaScreenState();
}

class _AyudaScreenState extends State<AyudaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 1;
                            });
                          },
                          child: const Text('Ayuda de Caja')),
                    )
                  : widget.caso == 1
                      ? const Text(
                          RecursosEstaticos.caja1Ayuda,
                          style: TextStyle(fontSize: 18),
                        )
                      : widget.caso == 2
                          ? const Text(
                              RecursosEstaticos.almacen1Ayuda,
                              style: TextStyle(fontSize: 18),
                            )
                          : widget.caso == 3
                              ? const Text(
                                  RecursosEstaticos.cliente1Ayuda,
                                  style: TextStyle(fontSize: 18),
                                )
                              : widget.caso == 4
                                  ? const Text(
                                      RecursosEstaticos.descuentos1Ayuda,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : widget.caso == 5
                                      ? const Text(
                                          RecursosEstaticos.mesas1Ayuda,
                                          style: TextStyle(fontSize: 18),
                                        )
                                      : widget.caso == 6
                                          ? Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20),
                                                  child: const Text(
                                                    RecursosEstaticos
                                                        .ajustesAyuda,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        widget.caso = 0;
                                                      });
                                                    },
                                                    child: const Text('Volver'))
                                              ],
                                            )
                                          : Container(),
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 2;
                            });
                          },
                          child: const Text('Ayuda de Almacen')),
                    )
                  : widget.caso == 1
                      ? const Text(
                          RecursosEstaticos.caja2Ayuda,
                          style: TextStyle(fontSize: 18),
                        )
                      : widget.caso == 2
                          ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: const Text(
                                    RecursosEstaticos.almacen2Ayuda,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.caso = 0;
                                      });
                                    },
                                    child: const Text('Volver'))
                              ],
                            )
                          : widget.caso == 3
                              ? Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: const Text(
                                        RecursosEstaticos.cliente2Ayuda,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.caso = 0;
                                          });
                                        },
                                        child: const Text('Volver'))
                                  ],
                                )
                              : widget.caso == 4
                                  ? const Text(
                                      RecursosEstaticos.mesas2Ayuda,
                                      style: TextStyle(fontSize: 18),
                                    )
                                  : widget.caso == 5
                                      ? Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: const Text(
                                                RecursosEstaticos.mesas2Ayuda,
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    widget.caso = 0;
                                                  });
                                                },
                                                child: const Text('Volver'))
                                          ],
                                        )
                                      : Container(),
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 3;
                            });
                          },
                          child: const Text('Ayuda de Clientes')),
                    )
                  : widget.caso == 1
                      ? const Text(
                          RecursosEstaticos.caja3Ayuda,
                          style: TextStyle(fontSize: 18),
                        )
                      : widget.caso == 4
                          ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: const Text(
                                    RecursosEstaticos.descuentos3Ayuda,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.caso = 0;
                                      });
                                    },
                                    child: const Text('Volver'))
                              ],
                            )
                          : Container(),
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 4;
                            });
                          },
                          child: const Text('Ayuda de Descuentos')),
                    )
                  : widget.caso == 1
                      ? Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                RecursosEstaticos.caja4Ayuda,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.caso = 0;
                                  });
                                },
                                child: const Text('Volver'))
                          ],
                        )
                      : Container(),
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 5;
                            });
                          },
                          child: const Text('Ayuda de Mesas')),
                    )
                  : Container(),
              widget.caso == 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.caso = 6;
                            });
                          },
                          child: const Text('Ayuda de Ajustes')),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
