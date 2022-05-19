import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:tpv/Recursos/RecursosEstaticos.dart';

import '../Recursos/ManejadorEstatico.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  final _focusUser = FocusNode();
  final _focusPass = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(RecursosEstaticos.appName),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: height*0.2,
                    child: Image.asset(RecursosEstaticos.logoNormal),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: RecursosEstaticos.isPCPlatform?width * 0.4:width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                labelText: 'Usuario',
                              ),
                              controller: _userController,
                              focusNode: _focusUser,
                              validator: (value) {
                                if (value.isEmpty) {
                                  _focusUser.requestFocus();
                                  return "El campo no puede quedar vacío";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: RecursosEstaticos.isPCPlatform?width * 0.4:width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: TextFormField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Contraseña',
                              ),
                              controller: _passController,
                              focusNode: _focusPass,
                              validator: (value) {
                                if (value.isEmpty) {
                                  _focusPass.requestFocus();
                                  return "El campo no puede quedar vacío";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                    child: ElevatedButton(
                      child: const Text('Iniciar Sesión'),
                      onPressed: () {
                        ManejadorEstatico.attemptLogin(
                            context, _formKey, _userController, _passController);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}