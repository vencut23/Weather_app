import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/additionalinfo.dart';
import 'package:flutter_application_2/hourcard.dart';

class Weather extends StatelessWidget {
  const Weather({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print('hello refresh');
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 20,
                  shape: const RoundedRectangleBorder(
                     borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Tempereature',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    color: Colors.white70,
                                ),
                                ),
                                SizedBox(
                                     height: 20,
                                ),
                                Icon(Icons.cloud,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('Rain',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.white70,
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                ),
              ),
              const SizedBox(height: 16,),
              const Text('Weather Information',
                   style: TextStyle(
                     fontWeight: FontWeight.w500,
                     fontSize: 20,
                   ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Row(
                    children: [
                      hourcard(time: '9:00', value: '300', icon: Icons.cloud),
                      hourcard(time: '9:00', value: '300', icon: Icons.beach_access),
                      hourcard(time: '9:00', value: '300', icon: Icons.air),
                      hourcard(time: '9:00', value: '300', icon: Icons.cloud),
                      hourcard(time: '9:00', value: '300', icon: Icons.beach_access),
                      hourcard(time: '9:00', value: '300', icon: Icons.air),
                    ],
                ),
              ),
              const SizedBox(height: 20,),
              const Text('Additional Informations',
                 style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                 ),
              ),
              const SizedBox(height: 16,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  additionalinfo(
                    value: '92',
                    icon: Icons.water_drop,
                    name: 'Humidity',
                  ),
                  additionalinfo(
                    value: '300',
                    icon: Icons.air,
                    name: 'Wind Speed',
                  ),
                  additionalinfo(
                    value: '1000',
                    icon: Icons.beach_access,
                    name: 'Pressure',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

