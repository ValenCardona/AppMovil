import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_vecinos/modelo/producto_dto.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'package:rapi_vecinos/persistencia/base_datos.dart';
import 'package:rapi_vecinos/persistencia/tienda_dao.dart';
import 'googlemaps.dart';

class VistaPedidos extends StatelessWidget {
  final List<Producto> productos;

  VistaPedidos(this.productos);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listado de pedidos',
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.orange,
        // Define the default font family.
        fontFamily: 'Georgia',
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
          headline6: TextStyle(
              fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 14.0, fontFamily: 'Hind', color: Colors.black),
        ),
      ),
      home: VistaListadoPedidos(productos),
    );
  }
}

class VistaListadoPedidos extends StatefulWidget {
  final List<Producto> productos;

  VistaListadoPedidos(this.productos);

  @override
  State<StatefulWidget> createState() {
    return _VistaListadoPedidosState();
  }
}

class _VistaListadoPedidosState extends State<VistaListadoPedidos> {
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de productos',
            style: TextStyle(fontSize: 35.0, color: Colors.black)),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.orange.shade400,
              Colors.orange.shade600,
              Colors.orange.shade800
            ])),
        child: _buildStoresList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Pedido enviado',
                    style: TextStyle(fontSize: 30.0, color: Colors.blue))),
          );
        },
        label: Text('Confirmar pedido'),
        icon: Icon(Icons.assignment_turned_in_outlined),
      ),
    );
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
        style: TextStyle(fontSize: 15.0, color: Colors.blueGrey.shade900),
      ),
      leading: Icon(
        Icons.paste,
        color: Colors.white,
        size: 40.0,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.black,
          size: 40.0,
        ),
        onPressed: () {
          BaseDatos.db.deletePedido(pdt);
          if (pdt.idTienda == pdt.idTienda) {
            BaseDatos.db.selectPedido().then((lista_productos) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VistaPedidos(lista_productos)),
              );
            });
          }
        },
      ),
    );
  }
}
