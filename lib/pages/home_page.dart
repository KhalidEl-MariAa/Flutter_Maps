// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_maps/widgets/modal_bottom_sheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? cS;
  Future<bool> checkservice() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF352F44), Color(0xFF5C5470)])),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(image: AssetImage('assets/images/meal.jpg')),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Family chicken Meal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    const Opacity(
                      opacity: 0.5,
                      child: Text(
                        '15 Fried chicken pieces + Family fries ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 105,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                          child: const Center(
                              child: Text(
                            '250.00 L.E ',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.black,
                            ),
                          )),
                        ),
                        Container(
                          height: 55,
                          width: 105,
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25))),
                          child: const Center(
                              child: Text(
                            '200.00 L.E ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(160, 30),
                        ),
                        onPressed: () async {
                          cS = await checkservice();
                          if (cS == false) {
                            buildAwesomeDialog(context);
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  const ModalBottomSheetBody(),
                            );
                          }
                        },
                        child: const Text('Make your order')
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void buildAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.topSlide,
      title: 'Location deactivation',
      desc: 'Please activate your device location ',
      btnOk: Center(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ))),
    ).show();
  }
}
