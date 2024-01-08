import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additionalinfo.dart';
import 'package:weather_app/hourcard.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  double temp=0;
 @override
  void initState() {
    super.initState();
    gettemp();
  }
  Future<Map<String,dynamic>> gettemp() async{
    final data;
    try{
    final res= await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=491e1cbf54e90cdb5128a32b98b12502'));
    
    data=jsonDecode(res.body);
   // data['list'][0]['main']['temp'];
    if(data['code']!='200'){
      throw 'unKnown error';
    }
    }catch(e){
      throw 'An unexcepted error here';
    }
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
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
        body: FutureBuilder(
          future: gettemp(),
          builder:(context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            print(snapshot);
            final data=snapshot.data!;
            final currenttemp=data['list'][0]['main'][temp];
            final currentsky=data['list'][0]['weather'][0]['main'];
            final currenthumidity= data['list'][0]['main']['humidity'];
            final currentwind=data['list'][0]['wind']['speed'];
            final currentpressure= data['list'][0]['main']['pressure'];
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
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text('${currenttemp} K',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30,
                                      color: Colors.white70,
                                  ),
                                  ),
                                  const SizedBox(
                                       height: 20,
                                  ),
                                  Icon(currentsky=='Clouds'||currentsky=='Rain'? 
                                  Icons.cloud:Icons.sunny,
                                    color: Colors.white70,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('$currentsky',
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
                //  SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child:  Row(
                //       children: [
                //          for(int i=0;i<5;i++)
                //                hourcard(time: data[i+1]['dt'].toString(), 
                //                         value: data[i+1]['main'][temp].toString(), 
                //                          icon: data[i+1]['weather'][0]['main'].toString() == 'Clouds'? Icons.cloud:Icons.sunny,
                //                         ),
                //       ],
                //   ),
                // ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: 
                       (context,index){
                        final currtime=DateTime.parse(data[index+1]['dt_txt'].toString());
                            return  hourcard(time: DateFormat.j().format(currtime), 
                                          value: data[index+1]['main'][temp].toString(), 
                                           icon: data[index+1]['weather'][0]['main'].toString() == 'Clouds'
                                           ||data[index+1]['weather'][0]['main'].toString() == 'Rain'? Icons.cloud:Icons.sunny,
                                          );
                       }
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
                      value: currenthumidity.toString(),
                      icon: Icons.water_drop,
                      name: 'Humidity',
                    ),
                    additionalinfo(
                      value:  currentwind.toString(),
                      icon: Icons.air,
                      name: 'Wind Speed',
                    ),
                    additionalinfo(
                      value: currentpressure.toString(),
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

