class Producto {
  late int idTienda;
  late int id;
  late String nombre;
  late String unidad;
  late double precio;
  late int cantidadCompra;

  //datos= 100;jamon;GRAMO;1000
  Producto.fromString(String datos) {
    List<String> Tokens = datos.split(';');
    this.idTienda = int.parse(Tokens[0]);
    this.id = int.parse(Tokens[1]);
    this.nombre = Tokens[2];
    this.unidad = Tokens[3];
    this.precio = double.parse(Tokens[4]);
    this.cantidadCompra = 0;
  }

  //#region FromJson
  Producto.fromJson(Map<String, dynamic> json)
      : idTienda = int.parse(json['idTienda'].toString()),
        id = int.parse(json['id'].toString()),
        nombre = json['nombre'].toString(),
        unidad = json['unidad'].toString(),
        precio = double.parse(json['precio'].toString()),
        cantidadCompra = int.parse(json['cantidadCompra'].toString());
//#endregion

//#region ToJson
  Map<String, dynamic> toJson() => {
        "idTienda": idTienda,
        "id": id,
        "nombre": nombre,
        "unidad": unidad,
        "precio": precio,
        "cantidadCompra": cantidadCompra
      };
//#endregion

}
