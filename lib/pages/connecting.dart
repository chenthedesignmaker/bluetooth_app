import 'package:flutter/material.dart';
import 'package:bluetooth_app/widgets/widgets.dart';

class Connecting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
          Hero(
              tag: "selected",
              child:
              Column(
                children: <Widget>[
                  deviceCard(height: 300, isExpanded: true),

                ],
              ),
          )

      ),
    );
  }
}
