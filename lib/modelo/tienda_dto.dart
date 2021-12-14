
enum TipoNegocio {Tienda,Drogueria, Lavanderia, Pizzeria, Ferreteria, Gimnasio, Panaderia, Carniceria, Fruver, Cigarreria, Minimarket,Asadero,Miscelanea }

class Tienda {
  String id;
  String nombre;
  String direccion;
  String telefono;
  String correo;
  TipoNegocio tipo;
  String logo;
  String coordenadas;

//region Constructor
  Tienda(
      {required this.id,
      required this.nombre,
      required this.direccion,
      required this.telefono,
      required this.correo,
      required this.tipo,
      required this.logo,
      required this.coordenadas});
//endregion

  //region FromJson
  Tienda.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        nombre = json['nombre'].toString(),
        direccion = json['direccion'],
        telefono = json['telefono'].toString(),
        correo = json['correo'].toString(),
        tipo = TipoNegocio.values.firstWhere(
            (element) => element.toString() == json['tipo'].toString()),
        logo=json['logo'].toString(),
        coordenadas=json['coordenadas'].toString();
  //endregion

  //region toJson
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "telefono": telefono,
        "correo": correo,
        "tipo": tipo..toString(),
        "logo":logo.toString(),
        "coordenadas":coordenadas.toString()
      };
//endregion
}
