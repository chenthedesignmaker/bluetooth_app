import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';



class Control extends StatefulWidget {
   Control({Key key, this.device}) : super(key: key);

  final BluetoothDevice device;



  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {

  BluetoothCharacteristic targetC;

  @override
  void initState(){
    //widget.device.discoverServices();
    findTargetChar();
  }




  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () => c.read(),
            onWritePressed: () => c.write("o".codeUnits),
                onNotificationPressed: () =>
                    c.setNotifyValue(!c.isNotifying),

          ),
        )
            .toList(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
    body:Column(

      children: <Widget>[
        RaisedButton(
          onPressed: (){
            widget.device.discoverServices();
            findTargetChar();

          },
          child: Text('Find services'),
        ),
        Text(widget.device.name),
        Text('services'),
        StreamBuilder<List<BluetoothService>>(
          stream: widget.device.services,
          initialData: [],
          builder: (c, snapshot) {
            return Column(
              children: _buildServiceTiles(snapshot.data),

            );
          },
        ),


    _FeedbackText(),


        RaisedButton(
          child: Text("Turn On"),
          onPressed:() => targetC.write('o'.codeUnits),
        ),
        RaisedButton(
          child: Text("Turn Off"),
          onPressed:() => targetC.write('f'.codeUnits),
        ),
      ],
    )



    );
  }

  findTargetChar() async {
    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach((service){
      print(service.uuid.toString());
      if(service.uuid.toString().contains('ffe0')){
        service.characteristics.forEach((c) {
          if(c.uuid.toString().contains('ffe1')){
            targetC = c;
            c.setNotifyValue(true);
            print('found char');
            setState(() {

            });
          }

        });
      }
    });

  }

  Future<Widget> latestMsg(){

  }


  Widget _FeedbackText(){
    if(targetC!=null){
      return StreamBuilder<List<int>>(
          stream: targetC.value,
          initialData: targetC.lastValue,
          builder: (c, snapshot) {
            final value = snapshot.data;
            //return Text(value.toString());
            return Text(String.fromCharCodes(value));
          });
    }else{
      return SizedBox();
    }
  }
}




class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key key, this.service, this.characteristicTiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Service'),
            Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Theme.of(context).textTheme.caption.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: Text('Service'),
        subtitle:
        Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}

class CharacteristicTile extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  // final List<DescriptorTile> descriptorTiles;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;
  final VoidCallback onNotificationPressed;

  const CharacteristicTile(
      {Key key,
        this.characteristic,
        //this.descriptorTiles,
        this.onReadPressed,
        this.onWritePressed,
        this.onNotificationPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: characteristic.value,
      initialData: characteristic.lastValue,
      builder: (c, snapshot) {
        final value = snapshot.data;
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Characteristic'),
                Text(
                    '0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}',
                    style: Theme.of(context).textTheme.body1.copyWith(
                        color: Theme.of(context).textTheme.caption.color))
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: EdgeInsets.all(0.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).iconTheme.color.withOpacity(0.5),
                ),
                onPressed: onReadPressed,
              ),
              IconButton(
                icon: Icon(Icons.file_upload,
                    color: Theme.of(context).iconTheme.color.withOpacity(0.5)),
                onPressed: onWritePressed,
              ),
              IconButton(
                icon: Icon(
                    characteristic.isNotifying
                        ? Icons.sync_disabled
                        : Icons.sync,
                    color: Theme.of(context).iconTheme.color.withOpacity(0.5)),
                onPressed: onNotificationPressed,
              )
            ],
          ),
          //children: descriptorTiles,
        );
      },
    );
  }
}
