import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectMap extends StatefulWidget {
  const SelectMap({super.key});

  @override
  State<SelectMap> createState() => _SelectMapState();
}

class _SelectMapState extends State<SelectMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 350,
      //  padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.orange),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          // borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            "assets/images/map.png",
            fit: BoxFit.cover,

            // height: 150.0,
            // width: 100.0,
          ),
          onTap: () {
            print("object");
          },
        ),
      ),
    );
  }
}
