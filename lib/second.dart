import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'main.dart';
import 'dart:async';
import './post_model.dart';
import 'package:http/http.dart' as http;
import 'history.dart';

class SecondPage extends StatefulWidget {
  SecondPage({this.patient, this.spimo, this.pedal});
  final String patient;
  final String spimo;
  final String pedal;

  String device;
  String spimoStart;
  String spimoStop;
  String spimoRefresh;

  String dvtStart;
  String dvtStop;
  String dvtRefresh;

  bool _spi_start = false;
  bool _dvt_start = false;
  String spimoCount = "0";
  String dvtCount = "0";


  var textColor = Colors.cyan[800];
  var buttonColor = Colors.blue[400];
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<SecondPage> {
  String _res_body = '';
//  Post _post = Post(this.patient,this.spimo,this.pedal);

//  Future<String> _getPost() async {
//    final _post = await getData(widget.patient,widget.device,"device_start");
//    setState(() { });
//  }

  Timer spimoTimer;
  Timer pedalTimer;
  Timer timer;

  void _showDialog(String res_body) {
    if (res_body == '0') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: new Text("The device has already returned."),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginApp()),
                    );
                  },
                  child: new Text("OK"),
                ) //FlatButton
              ],
            );
          } //builder
          ); //showDialog
    } //res_body:0
    else if (res_body == '1') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: new Text(
                  "You successfully signed out. Please return your device."),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginApp()),
                    );
                  },
                  child: new Text("OK"),
                ) //FlatButton
              ],
            );
          } //builder
          ); //showDialog
    } //res_body: 1
  }

  Material MyInfo(String patient, String spimo, String pedal) {
    return Material(
        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0x902196F3),
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
            child: Padding(
//          padding: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //patient
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          patient,
                          style: TextStyle(
                            color: widget.textColor,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
//                      //device
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          spimo,
//                          style: TextStyle(
//                            color: Colors.blue,
//                            fontSize: 16.0,
//                          ),
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          pedal,
//                          style: TextStyle(
//                            color: Colors.blue,
//                            fontSize: 16.0,
//                          ),
//                        ),
//                      ),

                      //signout
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {
                            print("signout pressed");
                            _res_body = postData(widget.patient, widget.spimo,
                                widget.pedal, "return_device");
                            _showDialog(_res_body);
                          },
                          color: Colors.red[700],
                          splashColor: Colors.blueGrey,
                          highlightColor: Colors.red[900],
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            "signout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      )
                    ]) //Row
                ) //padding,
            ) //container
        ); //material
  }

  Material MySpimo(String title, String device) {
    widget.spimoStart = "device_start";
    widget.spimoStop = "device_stop";
    widget.spimoRefresh = "device_refresh";
    widget.device = device;
    return Material(
        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0x902196F3),
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
            child: Padding(
//          padding: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          //title
                          Padding(
                            padding: const EdgeInsets.all(10.0),
//                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              title + ":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.textColor,
                                fontSize: 20.0,
                              ),
                            ),
                          ),

                          // status count
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Column(children: <Widget>[
                              Text(widget.spimo,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: widget.textColor,
                                    fontSize: 20.0,
                                  )),
//                              Text(widget.spimoCount,
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    color: Colors.blue,
//                                    fontSize: 20.0,
//                                  )),
                            ]),
                          ),

//
                        ], //widget
                      ),
                    ),
                    Container(height: 1.5, color: Colors.cyan[900]),
                    // Start Refresh Button
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text("BEST COUNT:",
                            style: TextStyle(
                              color: widget.textColor,
                              fontSize: 20.0,
                            ))),
                    Center(
//                        padding: const EdgeInsets.fromLTRB(10,10,10,10,),
//                        child: Center(
                        child: Text(widget.spimoCount,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ))
//                        )
                        ),

                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //Start, Done
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: widget._spi_start
                                        ? new RaisedButton(
                                            color: widget.buttonColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0)),
                                            onPressed: () {
                                              print(widget._spi_start);
                                              setState(() {
                                                widget._spi_start =
                                                    !widget._spi_start;
                                                spimoTimer.cancel();
                                              });
                                            },
                                            child: Text(
                                              "Done",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            ),
                                          )
                                        : new RaisedButton(  //start
                                            color: widget.buttonColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0)),
                                            onPressed: () {
                                              startCount(widget.patient, widget.device, "device_start");
                                              setState(() {
                                                widget._spi_start =
                                                    !widget._spi_start;
                                                spimoTimer = new Timer.periodic(
                                                    Duration(seconds: 1),
                                                    (spimoTimer) {
                                                  getData(widget.patient, widget.spimo,
                                                          "device_refresh")
                                                      .then(
                                                          (val) => setState(() {
                                                                widget.spimoCount =
                                                                    val;
                                                              }));
                                                });
                                              });
                                            },
                                            child: Text(
                                              "Start",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            )) // RaiseButton
                                    ), //Padding
                                //Refresh
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                        color: widget.buttonColor,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0)),
                                        onPressed: () {
                                          print("press refresh button");
                                          getData(widget.patient, widget.spimo,
                                                  "device_refresh")
                                              .then((val) => setState(() {
                                                    widget.spimoCount = "0";
                                                  }));
                                        },
                                        child: Text(
                                          "ReSet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
                                        )) // RaiseButton
                                    ), //Padding
                              ]),
                        ) //Padding
                        ) //center
                  ],
                ) //Row
                ) //Padding
            ) //center
        );
  }

  Material MyDVT(String title, String device) {
    widget.dvtStart = "device_start";
    widget.dvtStop = "device_stop";
    widget.dvtRefresh = "device_refresh";
    widget.device = device;
//    var dvTCount = "0";

    return Material(
        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0x902196F3),
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
            child: Padding(
//          padding: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //text
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Row(
                        children: <Widget>[
                          //title
                          Padding(
                            padding: const EdgeInsets.all(10.0),
//                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              title + ":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: widget.textColor,
                                fontSize: 20.0,
                              ),
                            ),
                          ),

                          // status count
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Column(children: <Widget>[
//                              Text("Count",
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    color: Colors.blue,
//                                    fontSize: 20.0,
//                                  )),
                              Text(widget.pedal,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: widget.textColor,
                                    fontSize: 20.0,
                                  )),
                            ]),
                          ),
                        ], //widget
                      ),
                    ),
                    Container(height: 1.5, color: Colors.cyan[900]),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(
                          10,
                          0,
                          10,
                          10,
                        ),
                        child: Text("COUNT:",
                            style: TextStyle(
                              color: widget.textColor,
                              fontSize: 20.0,
                            ))),
                    Center(
//                        padding: const EdgeInsets.fromLTRB(10,10,10,10,),
//                        child: Center(
                        child: Text(widget.dvtCount,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ))
//                        )
                        ),
                    // Start and Refresh Button
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: widget._dvt_start
                                        ? new RaisedButton(
                                            color: widget.buttonColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0)),
                                            onPressed: () {
//                                    print(widget._pedal_start);
                                              setState(() {
                                                widget._dvt_start =
                                                    !widget._dvt_start;
                                                pedalTimer.cancel();
                                              });
//                                    getData(widget.patient,widget.device,widget.dvtStart);
                                            },
                                            child: Text(
                                              "Done",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            ),
                                          )
                                        : new RaisedButton(  //start
                                            color: widget.buttonColor,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0)),
                                            onPressed: () {
                                              startCount(widget.patient, widget.device, "device_start");
                                              setState(() {
                                                widget._dvt_start =
                                                    !widget._dvt_start;
                                                pedalTimer = new Timer.periodic(
                                                    Duration(seconds: 1),
                                                    (pedalTimer) {
                                                      getData(widget.patient, widget.pedal,
                                                          "device_refresh")
                                                      .then((val) => setState(() {
                                                                widget.dvtCount = val;
                                                              }));
                                                });
                                              });
                                            },
                                            child: Text(
                                              "Start",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .display1,
                                            )) // RaiseButton
                                    ), //Padding
                                //Refresh
                                Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                        color: widget.buttonColor,
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0)),
                                        onPressed: () {

                                          getData(widget.patient, widget.pedal,
                                                  "device_refresh")
                                              .then((val) => setState(() {
//                                            Timer.cancel();
//                                      getData(widget.patient,widget.pedal,"device_refresh").then((val) =>setState((){
                                            widget.dvtCount = "0";
                                                  }));
                                        },
                                        child: Text(
                                          "ReSet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .display1,
                                        )) // RaiseButton
                                    ), //Padding
                              ]),
                        ) //Padding
                        ) //center
                  ],
                ) //Row
                ) //Padding
            ) //center
        );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Main Page',
              style: TextStyle(
                color: Colors.white,
              ))), //Appbar
//      body:
//        Center(
//          child: Text("Hello"),
//        )
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 15.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          MyInfo("${widget.patient}", "${widget.spimo}", "${widget.pedal}"),
//        MyInfo("patient", "device"),
          MySpimo("Spirometer", "Spimo"),
          MyDVT("DVT", "Pedal"),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 100),
          StaggeredTile.extent(2, 300.0),
          StaggeredTile.extent(2, 300.0),
//          StaggeredTile.extent(1, 300.0),
//          StaggeredTile.extent(2, 300.0),
        ],


        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => new patientData()),
                  );
                },
              )
            ],
          )
    ),
    );
  }
  //}
}
