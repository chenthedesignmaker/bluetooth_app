import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_app/pages/connecting.dart';

class bigRoundBtn extends StatefulWidget {
  final VoidCallback onTap;

  bigRoundBtn({Key key, @required this.onTap}) : super(key: key);

  @override
  _bigRoundBtnState createState() => _bigRoundBtnState();
}

class _bigRoundBtnState extends State<bigRoundBtn> {
  static Color offcolor = Colors.white30;
  static Color oncolor = Colors.cyan;
  Color btnColor = offcolor;
  bool btnState = false; //default, not pressed

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        constraints: BoxConstraints(minWidth: 250.0, minHeight: 250.0),
        fillColor: btnState ? oncolor : offcolor,
        child: Text(
          'Press',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        shape: CircleBorder(),
        padding: EdgeInsets.all(20.0),
        elevation: 20.0,
        onPressed: () {
          setState(() {
            btnState = !btnState;
            print('setting state');
            widget.onTap();
          });
        });
  }
}


class deviceCard extends StatelessWidget {
  deviceCard({Key key, this.device, this.height,this.isExpanded}):super(key:key);
  final double height;
  final bool isExpanded;
  final BluetoothDevice device;


  @override
  Widget build(BuildContext context) {
    return 
      
      SafeArea(
        child: Hero(
        tag:device.id.toString(),
        child: Card(

          color: Color.fromARGB(0, 0, 0, 0),
          margin: isExpanded?EdgeInsets.all(30.0):EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: GestureDetector(
            onTap: (){
              print('taped');
              device.connect();
              Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context){

                    return ConnectingPage(device:device);
                  }

              ));
            },
            child: Container(
              //margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(

                image: DecorationImage(
                  image:AssetImage('assets/images/deviceCardBG.png'),
                  centerSlice: new Rect.fromLTWH(100.0, 40.0, 440.0, 40.0),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  /*BoxShadow(
                    color: Color(0xFF2AC2D7).withAlpha(80),
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )*/
                ]
              ),
              height: isExpanded? null:height,
              //width: 500,
              //color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[


                  ListTile(
                    title: new Text(
                      device.name.length>0?device.name:device.id.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      device.id.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),

                  isExpanded?ConnectingStatus(device: device,):SizedBox(),


                ],
              ),
            ),
          ),
        ),
    ),
      );
  }
}


class ConnectingStatus extends StatefulWidget {
  ConnectingStatus({Key key, this.device}):super(key:key);
  final BluetoothDevice device;

  @override
  _ConnectingStatusState createState() => _ConnectingStatusState();
}

class _ConnectingStatusState extends State<ConnectingStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        margin: EdgeInsets.all(30),
        color: Colors.transparent,
        child: StreamBuilder<BluetoothDeviceState>(
            stream: widget.device.state,
            initialData:
            BluetoothDeviceState.disconnected,
            builder: (c, snapshot) {

              return Text(snapshot.data.toString(),
              style: TextStyle(
                color: Colors.white,
              ),);

              }

    ),
    );
  }
}
