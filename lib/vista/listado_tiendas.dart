import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'package:rapi_vecinos/persistencia/producto_dao.dart';
import 'package:rapi_vecinos/persistencia/tienda_dao.dart';
import 'package:rapi_vecinos/vista/listado_productos.dart';

class vistaTiendas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listado de Tiendas',
      home: VistaListadoTiendas(),
    );
  }
}

class VistaListadoTiendas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VistaListadoTiendasState();
  }
}

class _VistaListadoTiendasState extends State<VistaListadoTiendas> {
  final _stores = Tienda_dao.tiendas;
  final _biggerFont = const TextStyle(fontSize: 20.0, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tiendas'),
      ),
      body: _buildStoresList(),
    );
  }

  Widget _buildStoresList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _stores.length * 2,
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;

          return _buildRow(_stores[index]);
        });
  }

  Widget _buildRow(Tienda st) {
    return ListTile(
      title: Text(
        st.nombre,
        style: _biggerFont,
      ),
      subtitle: Text(
        st.direccion,
        style: TextStyle(fontSize: 15.0, color: Colors.amber),
      ),
      leading: (Image.network(
          'https://drive.google.com/uc?export=view&id=' + st.logo)),
      trailing: Icon(
        Icons.add_location,
        size: 25.0,
        color: Colors.lightGreen,
      ),
      onTap: () {
        var pDao = Productos_dao();
        pDao.ObtenerProductosDelServidor(st.id).then((lista_productos) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VistaProductos(lista_productos, st)),
              ),
            });
      },
    );
  }
}
