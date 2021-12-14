import 'package:path_provider/path_provider.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'package:rapi_vecinos/modelo/producto_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDatos {
  static late Database _database;
  final String _dataBaseName = "MiBarrioApp.db";
  BaseDatos._();
  static final BaseDatos db = BaseDatos._();
  var db_init=false;

  //#region Creacion de tablas
  static final String _CREATE_TIENDAS =
      "CREATE TABLE Tienda("
      "id INTEGER PRIMARY KEY,"
      "nombre TEXT,"
      "direccion TEXT,"
      "telefono TEXT,"
      "correo TEXT,"
      "tipo TEXT,"
      "logo TEXT,"
      "coordenadas TEXT"
      ")";

  static final String _CREATE_PEDIDO =
      "CREATE TABLE Pedido("
      "idTienda INTEGER,"
      "id INTEGER AUTO_INCREMENT,"
      "nombre TEXT,"
      "unidad TEXT,"
      "precio REAL,"
      "cantidadCompra INTEGER"
      ")";
  //#endregion

  Future<Database> get database async {
    if (db_init) {
      return _database;
    } else {
      _database = await iniciarBaseDatos();
    }
    return _database;
  }
  iniciarBaseDatos() async {
    var documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _dataBaseName);

    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(_CREATE_TIENDAS);
      await db.execute(_CREATE_PEDIDO);
      db_init = true;
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      if (oldVersion < newVersion) {
        await db.execute("DROP TABLE IF EXISTS Tienda");
        await db.execute(_CREATE_TIENDAS);
        await db.execute("DROP TABLE IF EXISTS Pedido");
        await db.execute(_CREATE_PEDIDO);
      }
    });
  }

  insertarTienda(Tienda td) async {
    final db =  await database;
    var res = await db.insert("Tienda", td.toJson());
    return res;
  }
  insertarProducto(Producto prd) async {
    final db = await database;
    var res = await db.insert("Pedido", prd.toJson());
    return res;
  }
  //#region SeleccionarTablas
  Future<List<Tienda>> selectTiendas(String query) async {
    final db = await database;
    var res = await db.rawQuery(query);
    List<Tienda> list=[];

    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Tienda.fromJson(t));
      }
    }
    return list;
  }
  Future<List<Producto>> selectPedido() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM Pedido');
    List<Producto> list = [];

    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Producto.fromJson(t));
      }
    }
    return list;
  }
  //#endregion

  //#region BorrarPedido

  Future<List<Producto>> deletePedido(Producto prt) async {
    final db = await database;
    var res = await db.rawQuery('DELETE FROM Pedido ' + 'WHERE idTienda =' + prt.idTienda.toString() + ' AND ' + 'id =' + prt.id.toString() + ' AND ' + 'cantidadCompra =' + prt.cantidadCompra.toString());
    List<Producto> list = [];

    if (res.isNotEmpty) {
      List<Map<String, dynamic>> temp = res.toList();
      for (Map<String, dynamic> t in temp) {
        list.add(Producto.fromJson(t));
      }
    }
    return list;
  }

//#endregion
}
