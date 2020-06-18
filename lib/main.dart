import 'package:flutter/material.dart';
import 'package:stoptrain/next_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stop_train',
      theme: ThemeData.light(),
      home: InputDataForm(),
    );
  }
}

class InputDataForm extends StatefulWidget {
  @override
  _InputDataFormState createState() => _InputDataFormState();
}

class _InputDataFormState extends State {
  // テキストフィールドを管理するコントローラを作成(入力内容の取得用)
  final textController = TextEditingController();


  double _speed = 0;
  double _brakingDistance = 0; //ブレーキ距離
  double _freeRunningDistance = 0; //空走距離
  double _stopDistance = 0; //停止距離
  double _deceleration = 4.5; //減速度を4.5に定義
  int _freeRunningTime = 2; //空走時分を2秒に定義

  //フォームの値を変数に入れる
  void _calcSpeed(inputText) {
    _speed = double.parse(textController.text); //小数に変換して変数に入れる
  }

  //制動距離の計算
  void _calcBrakingDistance(){
      _brakingDistance = (_speed * _speed) / (7.2 * _deceleration); //制動距離の計算
      _brakingDistance = (_brakingDistance * 10).ceil() / 10;
  }

  //空走距離の計算
  void _calcFreeRunningDistance(){
      _freeRunningDistance = (_speed / 3.6) * _freeRunningTime;
      _freeRunningDistance = (_freeRunningDistance * 10).ceil() / 10;
  }

  //停止距離の計算と表示
  void _calcStopDistance(){
    setState(() { //計算結果を表示する
      _stopDistance = _brakingDistance + _freeRunningDistance;
      _stopDistance = (_stopDistance * 10).ceil() / 10; //計算結果を切り上げ
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('電車は急に止まれない')
      ),

      body: Container (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text('ブレーキ距離計算機', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset('images/train.gif'),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('停止するまでに必要な距離を計算します。', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0), //フォームの余白
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number, // キーボードは数値のみ
                  // フォームの装飾を定義
                  decoration: InputDecoration(
                    labelText:"速度を入力してください",
                    hintText: '例：80',
                    icon: Icon(Icons.train),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,15,30,30),
                child: RaisedButton(
                  child: Text("計算する", style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    _calcSpeed(textController.text); //テキストフィールドの内容を取得して計算
                    _calcBrakingDistance(); //制動距離の計算
                    _calcFreeRunningDistance(); //空走距離の計算
                    _calcStopDistance(); //停止距離の計算（空走距離と制動距離の合計）

                    // テキストフィールドの文字を消す
                    textController.clear();

                    //次のページへ遷移する
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage(_stopDistance.toString(), _brakingDistance.toString(), _freeRunningDistance.toString())),
                      );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}