import 'package:flutter/material.dart';
import 'package:memo_app/utils/memo_list_store.dart';
import 'package:memo_app/utils/memo.dart';
import 'package:memo_app/component/card_button.dart';

class MemoInputPage extends StatefulWidget {
  static String id = 'memo_input_page';
  // Memoのモデル
  final Memo? memo;
  // コンストラクタ
  // Memoを引数で受け取った場合は更新、受け取らない場合は追加画面
  const MemoInputPage({Key? key, this.memo}) : super(key: key);

  // メモ入力画面の状態を生成する
  @override
  State<MemoInputPage> createState() => _MemoInputPageState();
}
// 役割
// メモの追加/更新
// メモリスト画面へ戻る

class _MemoInputPageState extends State<MemoInputPage> {
  // ストア
  final MemoListStore _store = MemoListStore();

  // 新規追加
  late bool _isCreateMemo;
  // メモ内容
  late String _text;

  @override
  void initState() {
    super.initState();
    var memo = widget.memo;

    _text = memo?.text ?? '';
    _isCreateMemo = memo == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 3,
                  decoration: const InputDecoration(
                    filled: false,
                    hintText: 'メモを入力してね',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 15.0,
                    ),
                  ),
                  controller: TextEditingController(text: _text),
                  onChanged: (String value) {
                    _text = value;
                  },
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: CardButton(
                  color: Colors.blue,
                  press: () {
                    if (_isCreateMemo) {
                      // メモを追加
                      _store.add(_text);
                    } else {
                      // メモを更新
                      _store.update(widget.memo!, _text);
                    }
                    // メモリスト画面へ戻る
                    Navigator.of(context).pop();
                  },
                  icon: Icons.check,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
