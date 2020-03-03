import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'control.dart';
import 'package:bluetooth_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BluetoothDevice device;
  ScanResult scanResult;
  var scanSubscription;
  var deviceConnection;
  List<String> discoveredDevice = [];

  String bleStatues = "doing nothing";

  @override
  void initState() {
    FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(
          'Select Device',
        ),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));
              },
              child: Text('Rescan')),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*FlatButton.icon(
                onPressed: () {
                  //_scanDevices();
                  FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));

                  //Navigator.pushNamed(context, '/control');
                },
                icon: Icon(Icons.attach_money),
                label: Text('RESCAN',
                style: TextStyle(

                  color: Colors.blue,
                ),)),
*/

            /*GestureDetector(
              onTap:(){
                Navigator.pushNamed(context, '/connecting');
              } ,
              child: Hero(
                tag:"selected",
                child: Text('hero')//deviceCard(height: 100,isExpanded: false,),
              ),
            ),
*/

            RefreshIndicator(
              onRefresh: () => (FlutterBlue.instance
                  .startScan(timeout: Duration(seconds: 4))),
              child: Column(
                children: <Widget>[
                  StreamBuilder<List<BluetoothDevice>>(
                    stream: Stream.periodic(Duration(seconds: 2))
                        .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data
                          .map((d) => ListTile(
                                title: Text(d.name),
                                subtitle: Text(d.id.toString()),
                                trailing: StreamBuilder<BluetoothDeviceState>(
                                  stream: d.state,
                                  initialData:
                                      BluetoothDeviceState.disconnected,
                                  builder: (c, snapshot) {
                                    if (snapshot.data ==
                                        BluetoothDeviceState.connected) {
                                      return RaisedButton(
                                          child: Text('OPEN'),
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  d.connect();
                                                  return Control(device: d);
                                                }),

                                                /*onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DeviceScreen(device: d))),*/
                                              ));
                                    }
                                    return Text(snapshot.data.toString());
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  StreamBuilder<List<ScanResult>>(
                    stream: FlutterBlue.instance.scanResults,
                    initialData: [],
                    builder: (c, snapshot) => Column(
                      children: snapshot.data
                          .map(
                            (r) => deviceCard(
                              device: r.device,
                              isExpanded: false,
                              height: 100.0,
                            ),
                            /*RaisedButton(
                                  child: Text(r.device.name),
                                  color: Colors.blue,
                                  onPressed: () =>
                                      Navigator.of(context)
                                          .push(
                                          MaterialPageRoute(builder: (context) {
                                            r.device.connect();

                                            return Control(device: r.device);
                                          })),
                                ),*/
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            /* floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
            if (snapshot.data) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: () => FlutterBlue.instance.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  onPressed: () => FlutterBlue.instance
                      .startScan(timeout: Duration(seconds: 4)));
            }
        },
      ),*/
          ],
        ),
      )),
    );
  }

/*
  void _scanDevices(){

    _flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = _flutterBlue.scanResults.listen((scanResult) {
      // do something with scan result
      device = scanResult.device;
      print('${device.name} found! rssi: ${scanResult.rssi}');
    });*/

// Stop scanning
//_flutterBlue.stopScan();
/*_flutterBlue = FlutterBlue.instance;
    if (_onDeviceConnectionRestored != null) {
      //_isPastSplashScreen = true;
    }

    bleStatues = "Scanning";

    print("Scanning for devices");
    try {
      scanSubscription = _flutterBlue.scan(timeout: Duration(seconds: 4)).listen(
            (scanResult) {
          String deviceName = scanResult.device.name;
          if(!discoveredDevice.contains(deviceName)&&deviceName!=""){
            print("unique");
            discoveredDevice.add(deviceName);
            setState(() {

            });
            print("Found device with name " + deviceName);
          }


          bleStatues = "Found device with name $deviceName";

          if (deviceName.compareTo(_deviceName.toLowerCase()) == 0) {
            //_connect(scanResult.device, _onDeviceConnectionRestored);
            bleStatues = "Ready to connect   $deviceName";
          }
        },
      );
    } catch (ex) {
      print(ex);
    }*/

}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, this.device}) : super(key: key);

  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(device.name);
  }
}
