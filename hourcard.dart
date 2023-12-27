
import 'package:flutter/material.dart';

class hourcard extends StatelessWidget {
  final String time;
  final String value;
  final IconData icon;
 const hourcard({super.key, required this.time, required this.value, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
                        elevation: 20,
                       child: Padding(
                         padding: EdgeInsets.all(8.0),
                         child: SizedBox(
                           width: 75,
                           child: Column(
                            children: [
                               Text(time,
                               style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                               ),
                               ),
                               const SizedBox(height: 8,),
                               Icon(icon),
                               const SizedBox(height: 8,),
                               Text(value),
                            ],),
                         ),
                       )
                      );
  }
}