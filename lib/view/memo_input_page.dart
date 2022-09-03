import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memo_app/component/card_button.dart';
import 'package:memo_app/utils/constants.dart';
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

Color kMemoColor = Colors.white;
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
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            const Positioned.fill(
              child: Image(
                image: AssetImage('images/wallpaper_img.webp'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(
                vertical: 50.0,
                horizontal: 20.0,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CardButton(
                      color: Colors.grey.shade700,
                      press: () {
                        // メモリスト画面へ戻る
                        Navigator.of(context).pop();
                      },
                      icon: FontAwesomeIcons.xmark,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 7,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      maxLines: null,
                      minLines: 7,
                      style: kCardTextStyle,
                      decoration: InputDecoration(
                        errorText: _validate ? 'メモがないよ！' : null,
                        errorStyle: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),

                        filled: true,
                        fillColor: kMemoColor,
                        hintText: 'メモを入力してね',
                        border: InputBorder.none,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        // enabledBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // focusedBorder: const OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.white,
                        //   ),
                        // ),
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
                  Expanded(
                    child: CardButton(
                      color: Colors.blue,
                      press: () {
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
                      icon: FontAwesomeIcons.check,
                    ),
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     shape: const CircleBorder(),
                  //   ),
                  //   onPressed: () {
                  //     // メモが空ならチェック
                  //     if (_text.isEmpty) {
                  //       _validate = true;
                  //       setState(() {});
                  //       return;
                  //     }
                  //     if (_isCreateMemo) {
                  //       // メモを追加
                  //       _store.add(_text);
                  //     } else {
                  //       // メモを更新
                  //       _store.update(widget.memo!, _text);
                  //     }
                  //     // メモリスト画面へ戻る
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: const Icon(
                  //     Icons.check,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
