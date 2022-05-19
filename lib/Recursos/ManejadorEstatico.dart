import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tpv/Clases/Usuario.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

import '../Actividades/MenuScreen.dart';

class ManejadorEstatico {
  // METODO ENCARGADO DE REALIZAR EL LOGIN
  static Future<void> attemptLogin(BuildContext ctx, var formKey,
      TextEditingController user, TextEditingController pass) async {
    bool running = true;
    if (formKey.currentState.validate()) {
      var body = {
        'usuario': user.text,
        'contrasena': pass.text,
      };
      AlertDialog alert = AlertDialog(
        content: Container(
          //width: 80,
          //height: 50,
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                const CircularProgressIndicator(),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text('Cargando...')),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              running = false;
              Navigator.pop(ctx, false);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
      showDialog(
        barrierDismissible: false,
        context: ctx,
        builder: (BuildContext context) {
          return alert;
        },
      );

      await getRequest('login', body: body).then((response) {
        Usuario respuesta;
        try {
          respuesta = Usuario.fromJson(jsonDecode(response.body));
          if (respuesta.logeado) {
            RecursosEstaticos.usuario = respuesta;
            if (running) {
              Navigator.pop(ctx, true);
              RemplazarActividad(ctx, MenuScreen());
            }
          } else {
            if (running) {
              Navigator.pop(ctx, false);
              AlertDialog dialog = AlertDialog(
                title: const Text("Error"),
                content: Container(
                  //margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    respuesta.error,
                    //style: TextStyle(fontSize: 18),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx, true);
                      attemptLogin(ctx, formKey, user, pass);
                    },
                    child: const Text(
                      "Reintentar",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              );
              showDialog(
                  barrierDismissible: false,
                  context: ctx,
                  builder: (BuildContext context) {
                    return dialog;
                  });
            }
          }
        } on Exception catch (exception) {
          /*if (running) {
              Navigator.pop(ctx, false);
            }*/
        } catch (error) {
          if (running) {
            Navigator.pop(ctx, false);
            AlertDialog dialog = AlertDialog(
              title: const Text("Error"),
              content: Container(
                //margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  "No se ha podido establecer la conexión con el servidor.",
                  //style: TextStyle(fontSize: 18),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx, true);
                    attemptLogin(ctx, formKey, user, pass);
                  },
                  child: const Text(
                    "Reintentar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            );
            showDialog(
                barrierDismissible: false,
                context: ctx,
                builder: (BuildContext context) {
                  return dialog;
                });
          }
        }
      });
    }
  }

  // METODO REMPLAZADOR DE ACTIVIDADES
  static void RemplazarActividad(BuildContext ctx, Object Actividad) {
    Navigator.pushReplacement(
      ctx,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => Actividad,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4.0, 0.0),
            end: Offset.zero,
          ).animate(anim),
          child: child, // child is the value returned by pageBuilder
        ),
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  // METODO LANZADOR DE ACTIVIDADES
  static void LanzarActividad(BuildContext ctx, Object Actividad) {
    Navigator.push(
      ctx,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => Actividad,
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4.0, 0.0),
            end: Offset.zero,
          ).animate(anim),
          child: child, // child is the value returned by pageBuilder
        ),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // METODO RECOGEDOR GET
  static Future<http.Response> getRequest(String url, {Map body, int id}) async {
    url == 'login'
        ? url = RecursosEstaticos.wsUrl +
            url +
            '?usuario=' +
            body['usuario'] +
            '&contrasena=' +
            body['contrasena']
        : url = RecursosEstaticos.wsUrl + url;
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (url.contains('login')) {
      var bodyPut = {
        'usuario': body['usuario'],
        'contrasena': body['contrasena'],
        'ultimo_login': DateTime.now().toString(),
      };
      await putRequest('login', bodyPut);
    }

    //print("${response.statusCode}");
    //print("${response.body}");
    return response;
  }

  // METODO RECOGEDOR POST
  static Future<http.Response> postRequest(String url, Map body) async {
    url = RecursosEstaticos.wsUrl + url;
    var JsonBody = jsonEncode(body);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: JsonBody,
    );
    //print("${response.statusCode}");
    //print("${response.body}");
    return response;
  }

  // METODO RECOGEDOR PUT
  static Future<http.Response> putRequest(String url, Map body) async {
    url = RecursosEstaticos.wsUrl + url;
    var JsonBody = jsonEncode(body);
    var response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: JsonBody,
    );
    //print("${response.statusCode}");
    //print("${response.body}");
    //print(jsonDecode(JsonBody));
    return response;
  }

  // METODO RECOGEDOR DELETE
  static Future<http.Response> deleteRequest(String url, int id) async {
    url = RecursosEstaticos.wsUrl + url + "/" + id.toString();
    var response = await http.delete(
      url,
    );
    //print("${response.statusCode}");
    //print("${response.body}");
    return response;
  }
}
