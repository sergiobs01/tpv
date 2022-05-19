class Descuento {
  Descuento({
    this.id,
    this.clienteId,
    this.cantidad,
    this.actualizado,
    this.creado,
    this.borrado,
    this.error,
  });

  int id;
  int clienteId;
  String clienteNom;
  int cantidad;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;

  factory Descuento.fromJson(Map<String, dynamic> json) => Descuento(
    id: json["id"],
    clienteId: json["cliente_id"],
    cantidad: json["cantidad"],
    actualizado: json['actualizado'],
    creado: json['creado'],
    borrado: json['borrado'],
    error: json['error'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cliente_id": clienteId,
    "cantidad": cantidad,
    'actualizado': actualizado,
    'creado': creado,
    'borrado': borrado,
    'error': error,
  };
}