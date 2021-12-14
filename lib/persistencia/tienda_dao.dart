import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'conexion_http.dart';
import 'dart:convert' as JSON;

class Tienda_dao {
  static final List<Tienda> tiendas = [];

  static Future<void> AgregarTiendasDelServidor() async{
    var srvConn = ServerConnection();
    await srvConn.select('Tiendas').then((datos_tiendas) {
      var json = JSON.jsonDecode(datos_tiendas);
      List records = json["data"];
      records.forEach((element) {
        tiendas.add(Tienda.fromJson(element));
      });
    });
  }
}