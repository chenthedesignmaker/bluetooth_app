import 'package:flutter/material.dart';
import 'package:bluetooth_app/widgets/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectingPage extends StatefulWidget {
  ConnectingPage({Key key, this.device}): super(key:key);
  final BluetoothDevice device;

  @override
  _ConnectingPageState createState() => _ConnectingPageState();
}

class _ConnectingPageState extends State<ConnectingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child:
          deviceCard(height: 500, isExpanded: true, device: widget.device,)

      ),
    );
  }
}
