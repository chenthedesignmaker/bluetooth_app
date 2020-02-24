import 'package:flutter/material.dart';

class bigRoundBtn extends StatefulWidget {
  final VoidCallback onTap;
bigRoundBtn({Key key, @required this.onTap}) : super(key: key);


  @override
  _bigRoundBtnState createState() => _bigRoundBtnState();
}

class _bigRoundBtnState extends State<bigRoundBtn> {
  static Color offcolor = Colors.black;
  static Color oncolor = Colors.blue;
  Color btnColor = offcolor;
  bool btnState = false; //default, not pressed




  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth:180.0, minHeight:180.0),
      fillColor: btnState?oncolor:offcolor,
      child: Text('Press'),
      shape: CircleBorder(),
      padding: EdgeInsets.all(20.0),
      elevation: 20.0,
      onPressed: (){
          setState(() {
            btnState=!btnState;
              print('setting state');
              widget.onTap();
          }) ;


      }
    );
  }
}
