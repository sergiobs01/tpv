class Cliente {
  int id;
  String nombre;
  String apellidos;
  String email;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;

  Cliente({
    this.id,
    this.nombre,
    this.apellidos,
    this.email,
    this.actualizado,
    this.creado,
    this.borrado,
    this.error
  });

  Cliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    email = json['email'];
    actualizado = json['actualizado'];
    creado = json['creado'];
    borrado = json['borrado'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['apellidos'] = this.apellidos;
    data['email'] = this.email;
    data['actualizado'] = this.actualizado;
    data['creado'] = this.creado;
    data['borrado'] = this.borrado;
    data['error'] = this.error;
    return data;
  }
}
