import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 右上に表示される"debug"ラベルを消す
      debugShowCheckedModeBanner: false,
      // アプリ名
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

// リスト一覧画面用Widget
class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) { //BuildContextを受け取ってWidgetを返す関数、文脈を受け取る感じ
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
        actions: <Widget>[
          Icon(Icons.add),
          Icon(Icons.settings),
        ],
      ),
      //データを元にListViewを作成

      body: ListView.builder(// ストローク可能なリスト表示,ListView.builder 関数に、要素数を itemCount として、 一個一個の要素に対しての表示部を itemBuilder として適応します。
        itemCount: todoList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton( //画面右下に憑依される丸いボタン
        onPressed: () async {
          //"push"で新規画面に遷移
          //リスト追加画面から渡される値を受け取る
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
              }),
              );//finalが指定された変数,再代入は不可
            if (newListText != null){
            // キャンセルした場合は newListText が null となるので注意
              setState(() {
                todoList.add(newListText);
              });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoAddPage extends StatefulWidget{ //Stateにデータを持ちStatefulWidgetでUI
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

//リスト追加用Widget
class _TodoAddPageState extends State<TodoAddPage> {//build関数をoverride（上書き）し、build関数内で描画するWidgetを返すことで描画を行なっています。
  // 入力されたテキストをデータとして持つ
  String _text = '';

  //テータを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        //余白をつける
        padding: EdgeInsets.all(64), //４方向の余白の大きさ
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Columnなら縦、Rowなら横,今回はColumn
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.blue)),
            TextField(
              // テキスト入力
                // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
                onChanged: (String value) {
                  // データが変更したことを知らせる（画面を更新する）
                  setState(() {
                    // データを変更
                    _text = value;
                  });
                },
            ),
              Container(
                //横幅一杯に広げる
                width: double.infinity,
                // リスト追加ボタン
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    // *** 追加する部分 ***
                    // "pop"で前の画面に戻る
                    // "pop"の引数から前の画面にデータを渡す
                    Navigator.of(context).pop(_text);
                  },
                  child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: FlatButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
            // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
              // データが変更したことを知らせる（画面を更新する）     //データ変更
           ], //ボタンをクリックした時の処理
        ),
      ),
    );
  }
}