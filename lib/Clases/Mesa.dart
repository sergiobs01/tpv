import 'Articulo.dart';

class Mesa {
  Mesa({
    this.id,
    this.nombre,
    this.actualizado,
    this.creado,
    this.borrado,
    this.error,
    this.articulos,
  });

  int id;
  String nombre;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;
  List<Articulo> articulos;

  factory Mesa.fromJson(Map<String, dynamic> json) => Mesa(
    id: json["id"],
    nombre: json["nombre"],
    actualizado: json['actualizado'],
    creado: json['creado'],
    borrado: json['borrado'],
    error: json['error'],
    articulos: List<Articulo>.from(json["articulos"].map((x) => Articulo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    'actualizado': actualizado,
    'creado': creado,
    'borrado': borrado,
    'error': error,
    'articulos': List<dynamic>.from(articulos.map((x) => x.toJson())),
  };
}