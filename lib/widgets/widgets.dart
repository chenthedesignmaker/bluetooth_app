import 'package:flutter/material.dart';

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
  deviceCard({Key key, this.height,this.isExpanded}):super(key:key);
  final double height;
  final bool isExpanded;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(20.0),
        height: isExpanded? null:height,
        //width: 500,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[


            Material( // had to use material or the text will be glitchy
              child: new Text(
                "I'm hero",
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.red,
                ),
              ),
            ),

            isExpanded?ConnectingStatus():SizedBox(),


          ],
        ),
      ),
    );
  }
}


class ConnectingStatus extends StatefulWidget {
  @override
  _ConnectingStatusState createState() => _ConnectingStatusState();
}

class _ConnectingStatusState extends State<ConnectingStatus> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Text('Connectiong'),
      ),
    );
  }
}
