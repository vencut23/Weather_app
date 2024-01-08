import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/additionalinfo.dart';
import 'package:flutter_application_1/hourcard.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  late Future<Map<String,dynamic>> weather; 
 @override
  void initState() {
    super.initState();
    weather=gettemp();
  }
  Future<Map<String,dynamic>> gettemp() async{
    final res= await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=491e1cbf54e90cdb5128a32b98b12502'));
    
    final data=jsonDecode(res.body);
    // temp=data['list'][0]['main']['temp'];
    // if(data['code']!='200'){
    //   throw 'unKnown error';
    // }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() { 
               weather=gettemp();
            });
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
        body: FutureBuilder(
          future: weather,
          builder:(context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return const Text('An error occured');
            }
             final data=snapshot.data!;
             final currtemp=data['list'][0]['main']['temp'];
             final currsky=data['list'][0]['weather'][0]['main'];
             final currpressure=data['list'][0]['main']['pressure'];
             final currhumidity=data['list'][0]['main']['humidity'];
             final currwind=data['list'][0]['wind']['speed'];
            return Padding(
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
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('$currtemp',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                      color: Colors.white70,
                                  ),
                                  ),
                                  const SizedBox(
                                       height: 20,
                                  ),
                                  Icon(currsky=='Rain'||currsky=='Cloud'? Icons.water_drop: currsky=='Snow'? Icons.snowing:Icons.sunny,
                                    color: Colors.white70,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('$currsky',
                                  style: const TextStyle(
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
                /* const SingleChildScrollView(
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
                ), */
                SizedBox(
                  height: 125,
                  child: ListView.builder(
                    itemCount: 20,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                       final currtime=data['list'][index]['dt_txt'];
                       final currsky=data['list'][index]['weather'][0]['main'];
                       final date=DateTime.parse(currtime.toString());
                        return hourcard(time: DateFormat.j().format(date).toString(), value: currsky.toString(), icon: currsky=='Rain'||currsky=='Clouds'? Icons.cloud:currsky=='Snow'?Icons.snowboarding:Icons.sunny);
                    },
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
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    additionalinfo(
                      value: currhumidity.toString(),
                      icon: Icons.water_drop,
                      name: 'Humidity',
                    ),
                    additionalinfo(
                      value: currwind.toString(),
                      icon: Icons.air,
                      name: 'Wind Speed',
                    ),
                    additionalinfo(
                      value: currpressure.toString(),
                      icon: Icons.beach_access,
                      name: 'Pressure',
                    ),
                  ],
                ),
            ],
          ),
                );
          },
        ),
    );
  }
}
