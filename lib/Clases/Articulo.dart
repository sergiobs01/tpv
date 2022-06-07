class Articulo {
  Articulo({
    this.id,
    this.articulo,
    this.cantidad,
    this.precio,
    this.url,
    this.observaciones,
    this.actualizado,
    this.creado,
    this.borrado,
    this.error,
  });

  int id;
  String articulo;
  int cantidad;
  double precio;
  String url;
  String observaciones;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;

  @override
  bool operator ==(Object other) => (other is Articulo) && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Articulo.fromJson(Map<String, dynamic> json) => Articulo(
        id: json['id'],
        articulo: json['articulo'],
        cantidad: json['cantidad'],
        precio: json['precio'].toDouble(),
        url: json['url'],
        observaciones: json['observaciones'],
        actualizado: json['actualizado'],
        creado: json['creado'],
        borrado: json['borrado'],
        error: json['error'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'articulo': articulo,
        'cantidad': cantidad,
        'precio': precio,
        'url': url,
        'observaciones': observaciones,
        'actualizado': actualizado,
        'creado': creado,
        'borrado': borrado,
        'error': error,
      };
}
