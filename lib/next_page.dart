import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NextPage extends StatelessWidget{
  NextPage(this._stopDistance, this._brakingDistance, this._freeRunningDistance);
  final String _stopDistance, _brakingDistance, _freeRunningDistance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('電車は急に止まれない'),
        actions: <Widget>[
          Icon(Icons.add),
          Icon(Icons.share),
        ],
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('条件', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text('車両：JR東日本E231系'),
            Text('ブレーキ：非常ブレーキ'),
            Text('減速度：4.5km/h/s'),
            Text('空走時分：2秒'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('images/train.gif'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,10),
              child: Text('停止までに必要な距離', style: TextStyle(fontSize: 25)),
            ),
            Text(_stopDistance + 'm', style: TextStyle(fontSize: 50)),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('ブレーキ距離：$_brakingDistance' + 'm'),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('空走距離：$_freeRunningDistance' + 'm'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,50,0,0),
              child: Center(
                child: RaisedButton(
                  child: Text('戻る', style: TextStyle(fontSize: 30),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}