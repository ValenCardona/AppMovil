import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rapi_vecinos/modelo/tienda_dto.dart';


class GoogleMapsView extends StatelessWidget {

  final Tienda _tienda;
  GoogleMapsView(this._tienda);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: GoogleMapsLocator(_tienda),
    );
  }
}

class GoogleMapsLocator extends StatefulWidget {
  final Tienda _tienda;
  GoogleMapsLocator(this._tienda);
  @override
  State<GoogleMapsLocator> createState() => GoogleMapsLocatorState();
}

class GoogleMapsLocatorState extends State<GoogleMapsLocator> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ll = LatLng(double.parse(widget._tienda.coordenadas.split(',')[0]),
        double.parse(widget._tienda.coordenadas.split(',')[1]));

    final CameraPosition _camaraPrincipal = CameraPosition(
      target: ll,
      zoom: 18.3,
    );


    final mk = Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(widget._tienda.id),
      position: ll,
      infoWindow: InfoWindow(
        title: widget._tienda.nombre,
        snippet: widget._tienda.tipo.toString().replaceAll('TipoNegocio.', ''),
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _camaraPrincipal,
        markers: {mk},
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
class MapsBogota extends StatelessWidget {
  MapsBogota();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _bogota = CameraPosition(
    //bearing: 192.8334901395799,
      target: LatLng(4.6486259,-74.2482369),
      zoom: 13.01);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _bogota,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),

    );
  }

}