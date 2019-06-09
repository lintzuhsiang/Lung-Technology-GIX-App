import 'package:flutter/material.dart';
import 'post_model.dart';

Material MyInfo(String patient, String device,void _showDialog,void ) {
  return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x902196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
          child: Padding(
//          padding: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //patient
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        patient,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    //device
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        device,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                        ),
                      ),
                    ),

                    //signout
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: (){
                          _showDialog();
                          PostData(widget.patient,widget.device,"return_device");
                        },
                        child: Text(
                          "signout",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )
                  ]) //Row
          ) //padding,
      ) //container
  ); //material
}

Material MyChart(String title, String device) {
//    if(device == 'Pedal'){
  widget.start = "device_start";
  widget.stop = "device_stop";
  widget.refresh = "device_refresh";
//    }else if (device == "Spimo"){
//      widget.start = "device_start";
//      widget.stop = "device_stop";
//      widget.refresh = "device_refresh";
//    }

  return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x902196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
          child: Padding(
//          padding: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //text
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Row(
                      children: <Widget>[
                        //title
                        Padding(
                          padding: const EdgeInsets.all(10.0),
//                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            ),
                          ),
                        ),

                        // status count
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
//                              Text("Count",
//                                  textAlign: TextAlign.left,
//                                  style: TextStyle(
//                                    color: Colors.blue,
//                                    fontSize: 20.0,
//                                  )),
                            Text(title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                )),
                          ]),
                        ),

//
                      ], //widget
                    ),
                  ),

                  // Start Refresh Button
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 10, 10),
                      child: Center(

                        child: Row(children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: title == "Spimometer"
                                  ? new RaisedButton(
                                onPressed: () {
                                  print(widget._spi_start);
                                  setState(() {
                                    widget._spi_start = !widget._spi_start;
                                  });
                                  getData(widget.start, widget.patient,
                                      device);

                                },
                                child: Text(
                                  "Start",
                                  style: Theme.of(context).textTheme.display1,
                                ),
                              )
                                  : new RaisedButton(
                                  onPressed: () {
                                    print(widget._spi_start);
                                    setState(() {
                                      widget._spi_start = !widget._spi_start;
                                    });
                                    getData(widget.start, widget.patient,
                                        device);

                                  },
                                  child: Text(
                                    "Done",
                                    style: Theme.of(context).textTheme.display1,
                                  )
                              ) // RaiseButton
                          ), //Padding
                          //Refresh
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RaisedButton(
                                  onPressed: () => getData(widget.refresh,widget.patient,device),
                                  child: Text(
                                    "Refresh",
                                    style: Theme.of(context).textTheme.display1,
                                  )) // RaiseButton
                          ), //Padding
                        ]),
                      ) //Padding
                  )//center
                ],
              ) //Row
          ) //Padding
      ) //center
  );
}