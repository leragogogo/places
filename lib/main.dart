import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstStatefulWidget(),
    );
  }
}

class MyFirstStatelessWidget extends StatelessWidget{
  int counter = 0;

  @override
  Widget build(BuildContext context){
    counter++;
    print("Счетчик StatelessWidget: $counter");
    return Scaffold(
      body: Container(
        child:const Center(
          child:Text("Hello!")
        )
      )
    );
  }
}

class MyFirstStatefulWidget extends StatefulWidget{
  @override
  State<MyFirstStatefulWidget> createState() => _MyFirstStatefulWidget();  
}
class _MyFirstStatefulWidget extends State<MyFirstStatefulWidget>{
  int counter = 0;

  @override
  Widget build(BuildContext context){
    counter++;
    print("Счетчик StatefulWidget: $counter");
    return Scaffold(
      body: Container(
        child:const Center(
          child:Text("Hello!")
        )
      )
    );
  }
}
