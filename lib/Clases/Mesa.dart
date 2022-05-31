class Mesa {
  Mesa({
    this.id,
    this.nombre,
    this.actualizado,
    this.creado,
    this.borrado,
    this.error,
  });

  int id;
  String nombre;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;

  factory Mesa.fromJson(Map<String, dynamic> json) => Mesa(
    id: json["id"],
    nombre: json["nombre"],
    actualizado: json['actualizado'],
    creado: json['creado'],
    borrado: json['borrado'],
    error: json['error'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    'actualizado': actualizado,
    'creado': creado,
    'borrado': borrado,
    'error': error,
  };
}