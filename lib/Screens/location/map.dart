// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:loginapp/const/themeColor.dart';
//
// class Location extends StatefulWidget {
//   @override
//   _LocationState createState() => _LocationState();
// }
//
// class _LocationState extends State<Location> {
//   bool mapToggle = false;
//
//   var currentLocation;
//
//   GoogleMapController? mapController;
//
//   Position? _currentPosition;
//
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _currentPosition = position;
//         _updateCameraPosition(LatLng(position.latitude, position.longitude));
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void _updateCameraPosition(LatLng target) {
//     mapController?.animateCamera(CameraUpdate.newLatLng(target));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Themes.color,
//         title: Text('Track Your Order'),
//       ),
//       body: Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//
//             width: MediaQuery.of(context).size.width,
//             child: mapToggle
//                 ? GoogleMap(
//               onMapCreated: onMapCreated,
//               myLocationEnabled: true,
//               mapType: MapType.normal,
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                       currentLocation.latitude, currentLocation.longitude),
//                   zoom: 19.0),
//             )
//                 : Center(
//               child: Text(
//                 'Loading ..please Wait..',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ),
//           )),
//     );
//   }
//
//   void onMapCreated(controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }
// }
