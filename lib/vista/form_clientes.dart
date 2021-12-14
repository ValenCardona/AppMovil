import 'package:flutter/material.dart';
import 'package:rapi_vecinos/persistencia/conexion_http.dart';

void main() => runApp(const VistaNuevoCliente());

class VistaNuevoCliente extends StatelessWidget {
  const VistaNuevoCliente({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro de Nuevo Cliente';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        // Define the default brightness and colors.
        primarySwatch: Colors.brown,
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
      home: Scaffold(
          appBar: AppBar(
              title: const Text(appTitle,
                  style: TextStyle(fontSize: 25.0, color: Colors.black))),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.black26,
                  Colors.black38,
                  Colors.black54
                ])),
            child: const FormularioNuevoCliente(),
          )),
    );
  }
}

// Create a Form widget.
class FormularioNuevoCliente extends StatefulWidget {
  const FormularioNuevoCliente({Key? key}) : super(key: key);

  @override
  FormularioNuevoClienteState createState() {
    return FormularioNuevoClienteState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FormularioNuevoClienteState extends State<FormularioNuevoCliente> {
  final _formKey = GlobalKey<FormState>();
  late final String _id,_nombre, _direccion, _telefono, _correo;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    //const estiloEtiqueta = TextStyle(fontSize: 15.0,color: Colors.black,
    //);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.lightBlue,
                filled: true,
                icon: Icon(Icons.person,color: Colors.blue,size: 30),
                hintText: "Ingrese su id",
                hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 15)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su id!.';
              } else {
                setState(() {
                  _id = value;
                });
              }
              return null;
            },
          ),
          TextFormField(style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.lightBlue,
                filled: true,
                icon: Icon(Icons.person,color: Colors.blue,size: 30),
                hintText: "Ingrese su Nombre",
                hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 15)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su nombre!.';
              } else {
                setState(() {
                  _nombre = value;
                });
              }
              return null;
            },
          ),

          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.lightBlue,
                filled: true,
                icon: Icon(Icons.person,color: Colors.blue,size: 30),
                hintText: "Ingrese su Direccion",
                hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 15)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su dirección!.';
              }{
                setState(() {
                  _direccion = value;
                });
              }
              return null;
            },
          ),

          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.lightBlue,
                filled: true,
                icon: Icon(Icons.person,color: Colors.blue,size: 30),
                hintText: "Ingrese el numero de Telefono",
                hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 15)
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su teléfono!.';
              }{
                setState(() {
                  _telefono = value;
                });
              }
              return null;
            },
          ),

          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                fillColor: Colors.lightBlue,
                filled: true,
                icon: Icon(Icons.person,color: Colors.blue,size: 30),
                hintText: "Ingrese su corrreo",
                hintStyle: TextStyle(color: Colors.yellow, fontStyle: FontStyle.italic,fontSize: 15)
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor escriba su correo electrónico!.';
              }{
                setState(() {
                  _correo = value;
                });
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  var datos=_nombre + ';'+ _direccion+ ';'+ _telefono+ ';'+ _correo;
                  var con=ServerConnection();
                  con.insert('Clientes', datos);
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Datos Guardados')),
                  );
                }
              },
              child: const Text(' Registrar cliente'),
            ),
          ),
        ],
      ),
    );
  }
}