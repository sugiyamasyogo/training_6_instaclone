import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/view_models/post_view_model.dart';

import '../../../../data_models/location.dart';

class MapScreen extends StatefulWidget {

  final Location location;

  const MapScreen({Key? key,required this.location}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  late LatLng _latLng;
  late CameraPosition _cameraPosition;
  GoogleMapController? _mapController;
  Map<MarkerId,Marker> _markers = <MarkerId,Marker>{};

  @override
  void initState() {
    _latLng = LatLng(widget.location.latitude,widget.location.longitude);
    _cameraPosition = CameraPosition(target: _latLng,zoom: 10.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).selectPlace),
        actions: [
          IconButton(
              onPressed: () => _onPlaceSelected(),
              icon: Icon(Icons.done),
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        onMapCreated: onMapCreated,
        onTap: onMapTapped,
        markers: Set<Marker>.of(_markers.values),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
   _mapController = controller;
  }

  void onMapTapped(LatLng latLng) {
    print("selected place:$latLng");
    _latLng = latLng;
    _createMarker(_latLng);
  }

  void _createMarker(LatLng latLng) {
    final markerId = MarkerId("selected");
    final marker = Marker(markerId: markerId, position: latLng,);
    setState(() {
      _markers[markerId] = marker;
    });
  }

  _onPlaceSelected() async {
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.updateLocation(_latLng.latitude,_latLng.longitude);
    Navigator.pop(context);
  }


}
