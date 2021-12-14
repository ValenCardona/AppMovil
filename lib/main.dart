import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';
import 'package:rapi_vecinos/persistencia/base_datos.dart';
import 'package:rapi_vecinos/persistencia/tienda_dao.dart';
import 'package:rapi_vecinos/vista/vista_principal.dart';


Future<void> main() async {
  Tienda_dao.AgregarTiendasDelServidor().then((value) => runApp(RapiVecinosMainview()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}



