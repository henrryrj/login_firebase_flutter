import 'dart:convert';
class Usuario {
  Usuario({
    this.name = "",
    this.telefono = -1,
    this.direccion = "",
    this.genero = "",
    this.email = "",
    this.pass = "",
  });
  String? id;
  String name;
  int? telefono;
  String direccion;
  String genero;
  String email;
  String pass;
  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        genero: json["genero"],
        email: json["email"],
        pass: json["pass"],
      );
  Map<String, dynamic> toMap() => {
        "name": name,
        "telefono": telefono,
        "direccion": direccion,
        "genero": genero,
        "email": email,
        "pass": pass,
      };

  factory Usuario.deDynamicUser(dynamic json) => Usuario(
        name: json["name"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        genero: json["genero"],
        email: json["email"],
        pass: json["pass"],
      );
  @override
  String toString() {
    return '{name: ${this.name}, telefono: ${this.telefono} direccion: ${this.direccion} genero: ${this.genero} email: ${this.genero} pass: ${this.pass}}';
  }
}
