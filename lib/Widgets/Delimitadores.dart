import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final _text;
  double size = 0;

  Header(this._text, {this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
      child: Text(
        _text,
        style: TextStyle(
            fontSize: size == 0 ? 16 : size,
            color: Colors.black54,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Space extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      indent: 4,
      endIndent: 4,
      color: Colors.grey,
    );
  }
}
