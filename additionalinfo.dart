
import 'package:flutter/material.dart';

class additionalinfo extends StatelessWidget {
  final IconData icon;
  final String name;
  final String value;
  const additionalinfo({
    super.key, required this.icon, required this.name, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:100,
      child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              Icon(icon,
                   size: 30,
                 ),
                 const SizedBox(height: 8,),
                 Text(name,
                       style: const TextStyle(
                        fontWeight: FontWeight.w300,
                       ),
                  ),
                  const SizedBox(height: 8,),
                  Text(value),
            ],
        ),
      ),
    );
  }
}

