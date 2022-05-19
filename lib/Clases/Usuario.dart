class Usuario {
  String usuario;
  String contrasena;
  String nombre;
  bool logeado;
  bool actualizado;
  bool creado;
  bool borrado;
  String error;

  Usuario(
      {this.usuario,
        this.contrasena,
        this.nombre,
        this.logeado,
        this.actualizado,
        this.creado,
        this.borrado,
        this.error});

  Usuario.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    contrasena = json['contrasena'];
    nombre = json['nombre'];
    logeado = json['logeado'];
    actualizado = json['actualizado'];
    creado = json['creado'];
    borrado = json['borrado'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuario'] = this.usuario;
    data['contrasena'] = this.contrasena;
    data['nombre'] = this.nombre;
    data['logeado'] = this.logeado;
    data['actualizado'] = this.actualizado;
    data['creado'] = this.creado;
    data['borrado'] = this.borrado;
    data['error'] = this.error;
    return data;
  }
}