import 'package:flutter/material.dart';
import 'package:memo_app/utils/memo_list_store.dart';
import 'package:memo_app/utils/memo.dart';

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
  // final titleController = TextEditingController();
  bool _validate = false;
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            const Positioned.fill(
              child: Image(
                image: AssetImage('images/wood-texture.webp'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 20.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    // flex: 5,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      maxLines: null,
                      minLines: 6,
                      style: const TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 0.5,
                        height: 1.6,
                      ),
                      decoration: InputDecoration(
                        errorText: _validate ? 'メモがないよ！' : null,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'メモを入力してね',
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      // メモが空ならチェック
                      if (_text.isEmpty) {
                        _validate = true;
                        setState(() {});
                        return;
                      }
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
                    child: const Icon(
                      Icons.check,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
