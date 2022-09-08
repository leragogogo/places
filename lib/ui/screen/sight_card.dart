import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';


class SightCard extends StatelessWidget{
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:32,top:10),
      child: Column(
        children:[ 
          Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color:Colors.blueAccent,
                  ),
                  height: 96,
                  width: 328,
                ),
                Positioned(
                  top:19,
                  right: 18,
                  child: Container(
                    height:20,
                    width:20,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top:16,
                  left: 16,
                  child: Text(
                    sight.type,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
          ),
          Container(
            height: 92,
            width: 328,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color:Color.fromRGBO(245,245, 245, 1),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left:16,top:16),
                  alignment: Alignment.topLeft,
                  child: Text(
                    sight.name,
                    style: const TextStyle(
                      color: Color.fromRGBO(37, 40, 73, 1),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left:16,top:2,right: 16),
                  alignment: Alignment.topLeft,
                  child: Text(
                    sight.details,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color.fromRGBO(124, 126, 146, 1),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
   }

}