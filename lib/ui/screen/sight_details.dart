import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightDetailsScreen extends StatelessWidget{
  final Sight sight;

  SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: double.infinity,
              color: Colors.blueAccent,
              height: 360,
            ),
            Positioned(
              top:36,
              left:16,
              child: Container(
                width: 32,
                height:32,
                color:Colors.white,
              ),
            ),
          ],
          ),
          Container(
            padding: const EdgeInsets.only(left:16,top:24),
            alignment: Alignment.topLeft,
            child: Text(
              sight.name,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),  
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left:16,top:2),
            alignment: Alignment.topLeft,
            child: Text(
              sight.type,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),  
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left:16,top:24,right:16),
            alignment: Alignment.topLeft,
            child: Text(
              sight.details,
              style: const TextStyle(
                color: Color.fromRGBO(37, 40, 73, 1),
                fontSize: 14,
                fontFamily: 'Roboto',
              ),  
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:16,top:24,right:16),
            child: Container(
              padding: const EdgeInsets.only(left:16,top:15,right:16,bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromRGBO(76, 175, 80, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left:5),
                    child: Text(
                      'ПОСТРОИТЬ МАРШРУТ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 39,
            color:Color.fromRGBO(124, 126, 146, 1),
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                'Запланировать',
                style: TextStyle(
                  color: Color.fromRGBO(37, 40, 73, 1),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
              Text(
                'Избранное',
                style: TextStyle(
                  color: Color.fromRGBO(37, 40, 73, 1),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ],
      ),
    );
   }
}