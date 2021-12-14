import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_vecinos/modelo/producto_dto.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'package:rapi_vecinos/persistencia/base_datos.dart';
import 'package:rapi_vecinos/persistencia/producto_dao.dart';
import 'googlemaps.dart';
import 'listado_pedidos.dart';

class VistaProductos extends StatelessWidget {
  final List<Producto> productos;
  final Tienda _tienda;
  VistaProductos(this.productos, this._tienda);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listado de Productos',
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.grey,
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
          headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.deepOrange),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.deepOrange),
        ),
      ),
      home: VistaListadoProductos(productos, _tienda),
    );
  }
}

class VistaListadoProductos extends StatefulWidget {
  final List<Producto> productos;
  final Tienda _tienda;
  VistaListadoProductos(this.productos, this._tienda);

  @override
  State<StatefulWidget> createState() {
    return _VistaListadoProductosState();
  }
}

class _VistaListadoProductosState extends State<VistaListadoProductos> {
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);
  void handleClick(int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GoogleMapsView(widget._tienda)),
        );
        break;
      case 1:
        BaseDatos.db.selectPedido().then((lista_productos) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VistaPedidos(lista_productos)),
          );
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Productos',
              style: TextStyle(fontSize: 35.0, color: Colors.black)),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Ver en Google Maps')),
                PopupMenuItem<int>(
                    value: 1, child: Text('Ver Carrito de Compras')),
              ],
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue.shade400,
            Colors.blue.shade600,
            Colors.blue.shade800
          ])),
          child: _buildStoresList(),
        ));
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.productos.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          return _buildRow(widget.productos[index]);
        });
  }

  Widget _buildRow(Producto pdt) {
    return ListTile(
      title: Text(
        pdt.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        pdt.precio.toString(),
        style: TextStyle(fontSize: 15.0, color: Colors.brown.shade800),
      ),
      leading: Icon(
        Icons.archive_outlined,
        size: 30.0,
        color: Colors.white,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.add_shopping_cart,
          size: 30.0,
          color: Colors.white70,
        ),
        onPressed: () {
          int i = 0;
          pdt.cantidadCompra = i + 1;
          BaseDatos.db.insertarProducto(pdt);
          },
      ),
    );
  }
}
