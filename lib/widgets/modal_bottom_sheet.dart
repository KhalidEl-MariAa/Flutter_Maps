// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class ModalBottomSheetBody extends StatefulWidget {
  const ModalBottomSheetBody({super.key});

  @override
  State<ModalBottomSheetBody> createState() => _ModalBottomSheetBodyState();
}
GlobalKey<FormState> formkey = GlobalKey();
class _ModalBottomSheetBodyState extends State<ModalBottomSheetBody> {
  int counter = 0;
  bool? cl;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Amount : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                counter++;
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 30,
                            )),
                        Text(
                          '$counter',
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                counter--;
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline_outlined,
                              size: 30,
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please enter your Name';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Customer Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please enter your Number';
                          }
                          else{
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    TextButton(
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.amber),
                        onPressed: () async {
                          if(formkey.currentState!.validate()){
                          LocationPermission cp =
                              await Geolocator.checkPermission();
                          if (cp == LocationPermission.denied ||
                              cp == LocationPermission.deniedForever ||
                              cp == LocationPermission.unableToDetermine) {
                            await Geolocator.requestPermission();
                            cp = await Geolocator.checkPermission();
                            if (cp == LocationPermission.denied ||
                                cp == LocationPermission.deniedForever ||
                                cp == LocationPermission.unableToDetermine) {
                              buildAwesomeDialogForPermission(context);
                            }
                          } else {
                            buildAwesomeDialogForLocation(context,cl);
                          }
                        }},
                        child: const Text(
                          'Choose your location',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }

  void buildAwesomeDialogForLocation(BuildContext context,bool? cl) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.topSlide,
      title: 'Where are you?',
      btnCancel: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: ()async {
            cl=true;
            Navigator.pop(context);
            Position currentLocation= await Geolocator.getCurrentPosition();
            Navigator.pushNamed(context, 'mappage',arguments: [currentLocation,cl]);
          },
          child: const Text(
            'Current Location',
            style: TextStyle(color: Colors.white, fontSize: 13),
          )),
      btnOk: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: ()async {
            cl=false;
            Navigator.pop(context);
             Position currentLocation= await Geolocator.getCurrentPosition();
             Navigator.pushNamed(context, 'mappage',arguments: [currentLocation,cl]);
          },
          child: const Text(
            'Select Location',
            style: TextStyle(color: Colors.white, fontSize: 13),
          )),
    ).show();
  }

  void buildAwesomeDialogForPermission(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.topSlide,
        title: 'Location permission required',
        desc: 'Please enable location permission in the app settings.',
        btnOk: Center(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings();
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.white),
              )),
        )).show();
  }
}
