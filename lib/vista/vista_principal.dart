import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapi_vecinos/persistencia/base_datos.dart';
import 'package:rapi_vecinos/vista/listado_pedidos.dart';
import 'form_clientes.dart';
import 'googlemaps.dart';
import 'listado_tiendas.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RapiVecinosMainview extends StatefulWidget {
  @override
  State<RapiVecinosMainview> createState() => _RapiVecinosMainviewState();
}

class _RapiVecinosMainviewState extends State<RapiVecinosMainview> {
  List<String> images = [
    "images/listadotienda.png",
    "images/registrarclientes.png",
    "images/realizarpedido.jpg",
    "images/configuracion.jpg"
  ];
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          print(message.notification!.body);
          print(message.notification!.title);
        }
        print(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (messagge) {
        final routeMessagge = messagge.data["route"];
        print(routeMessagge);
        //Navigator.of(context).pushNamed(routeMessagge);
      },
    );
    super.initState();
  }

  int _selectedIndex = 0;
  Widget _buildCelda(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => vistaTiendas()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VistaNuevoCliente()),
          );
        }else if (index == 2) {
          BaseDatos.db.selectPedido().then((lista_productos) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VistaPedidos(lista_productos)),
            );
          });
        }else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MapsBogota()),
            );
        }

      },
      child: Container(
        color: Colors.blue.shade600,
        padding: const EdgeInsets.all(8),
        child: Image.asset(images[index]),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Rapi Vecinos"),
          backgroundColor: Colors.red,
        ),
        body: Container(
            padding: EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (context, index) => _buildCelda(context, index),
            )),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Tiendas',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Clientes',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_sharp),
              label: 'pedidos',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_location),
              label: 'Maps',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
