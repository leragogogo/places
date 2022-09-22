import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class SightDetailsScreen extends StatelessWidget{
  final Sight sight;

  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              width: double.infinity,
              height: 360,
              child: Image.network(
                sight.url,
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null?child : const CupertinoActivityIndicator(),
                fit: BoxFit.fitHeight,
              ),
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
              style: nameDetailsTextStyle,  
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left:16,top:2),
            alignment: Alignment.topLeft,
            child: Text(
              sight.type,
              style: typeAndDetailsTextStyle,  
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left:16,top:24,right:16),
            alignment: Alignment.topLeft,
            child: Text(
              sight.details,
              style: typeAndDetailsTextStyle, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:16,top:24,right:16),
            child: Container(
              padding: const EdgeInsets.only(left:16,top:15,right:16,bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: planButtonColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:5),
                    child: Text(
                      buildRouteButtonText,
                      style: buildRouteButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 39,
            color: textColor,
            indent: 16,
            endIndent: 16,
            thickness: 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                planButtomText,
                style: buttomTextStyle,
              ),
              Text(
                favouriteButtonText,
                style: buttomTextStyle,
                ),
            ],
          ),
        ],
      ),
    );
   }
}