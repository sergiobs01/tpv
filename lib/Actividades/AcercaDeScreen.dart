import 'package:flutter/material.dart';

import '../Recursos/RecursosEstaticos.dart';

class AcercaDeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: height * 0.5,
              child: Image.asset(RecursosEstaticos.logoNormal),
            ),
            const Text(
              'Desarrollado por: Sergio Bataneros Sánchez',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              'Curso: 2021/22',
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              'I.E.S. Trassierra',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
