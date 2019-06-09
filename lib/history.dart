import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class patientData extends StatefulWidget{
//  patientData();
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<patientData>{

  Widget build(BuildContext content){
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "Patient History Data",
      style: TextStyle(
        color: Colors.white,
      ))),
      body: StaggeredGridView.count(
    crossAxisCount: 2,
    crossAxisSpacing: 12.0,
    mainAxisSpacing: 15.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    children: <Widget>[

    ],
    staggeredTiles: [
      StaggeredTile.extent(2,300),
       StaggeredTile.extent(2,300),

    ],


    ),

    );
  }
}


Material myChart(){
  return Material(
    color: Colors.white,
    elevation: 14.0,
    shadowColor: Color(0x902196F3),
    borderRadius: BorderRadius.circular(24.0),
    child: Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
      )
    )
  );
}