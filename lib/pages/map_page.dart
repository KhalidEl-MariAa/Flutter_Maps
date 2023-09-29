// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
//cgjnj
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> markers = {};
  LatLng? chosenLocation;
  List<Placemark> p = [];

  @override
  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)!.settings.arguments as List;
    LatLng markerpos = LatLng(args[0].latitude, args[0].longitude);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton( 
              onPressed: args[1]==false? () async {
                if (chosenLocation == null||chosenLocation==LatLng(args[0].latitude, args[0].longitude)) {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      title: 'Choose place',
                      desc: "You didn't choose location ",
                      btnOk: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'),
                        ),
                      )
                      ).show();


                  
                } else {
                  p = await placemarkFromCoordinates(chosenLocation!.latitude, chosenLocation!.longitude);
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      title: 'Confirmation',
                      
                      body:  Column(
                        children: [
                          Text('Your country is : ${p[0].country}'),
                          Text('Your city is : ${p[0].locality}'),
                          Text('Your street is : ${p[0].street}'),
                        ],
                      ),
                      btnOk: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      btnCancel: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                          
                        },
                        child: const Text('No'),
                      )).show();
                }
              }:
              () async{
                p = await placemarkFromCoordinates(chosenLocation!.latitude, chosenLocation!.longitude);

                AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      title: 'Confirmation',

                      body:  Column(
                        children: [
                          Text('Your country is : ${p[0].country}'),
                          Text('Your city is : ${p[0].locality}'),
                          Text('Your street is : ${p[0].street}'),
                        ],
                      ),
                      btnOk: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      btnCancel: TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                          
                        },
                        child: const Text('No'),
                      )).show();
              },
              child: const Text('Select Location'))
        ],
        title: const Text('Location'),
        centerTitle: true,
      ),
      body: GoogleMap(
          onTap: args[1] == false
              ? (argument) {
                  if (args[1] == false) {
                    chosenLocation = argument;
                    setState(() {
                      markerpos = argument;
                      markers.add(Marker(
                          markerId: const MarkerId('2'),
                          position: markerpos,
                          infoWindow:
                              const InfoWindow(title: 'Chosen Location')));
                    });
                  }
                }
              : (argument) {
                  print('aha');
                },
          onMapCreated: (controller) {
            chosenLocation = LatLng(args[0].latitude, args[0].longitude);
            setState(() {
              markers.add(Marker(
                  markerId: const MarkerId('1'),
                  position: markerpos,
                  infoWindow: const InfoWindow(title: 'Your location now')));
            });
          },
          markers: markers,
          initialCameraPosition: CameraPosition(
              target: LatLng(args[0].latitude, args[0].longitude), zoom: 16)),
    );
  }
}
  
/* 
open map found a marker on place we determined
----------------------------------------------
GoogleMap(
  onTap: (argument) {
          setState(() {
            markerpos=argument;
            markers.add( Marker(
            markerId: const MarkerId('2'),
            position: markerpos ));
          }); // ontap on place put a marker 
        },
        onMapCreated: (controller) {
          setState(() {
            markers.add(const Marker(
              markerId: MarkerId('1'),
              position: LatLng(30.033333, 31.233334),
              infoWindow:  InfoWindow(
              title: 'Cairo city',
              snippet: 'Its Egypt capital and one of the most important cities 
            )
              )//marker
            );
          });
        },
        markers: markers, // markers is set we created 
        initialCameraPosition:const CameraPosition(
          target: LatLng(30.033333, 31.233334),
          zoom: 10)
          ),
          */