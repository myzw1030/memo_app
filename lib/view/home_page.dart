import 'package:flutter/material.dart';
import 'package:memo_app/utils/memo_list_store.dart';
import 'package:memo_app/view/memo_input_page.dart';
import 'package:memo_app/utils/memo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  // コンストラクタ
  const HomePage({Key? key}) : super(key: key);

  // Memoリスト画面の生成
  @override
  State<HomePage> createState() => _HomePageState();
}

// 役割
// メモリストを表示
// メモの追加/編集画面へ遷移
// メモの削除
class _HomePageState extends State<HomePage> {
  // ストア
  final MemoListStore _store = MemoListStore();

  // メモ編集画面に遷移
  void _pushMemoInputPage([Memo? memo]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MemoInputPage(memo: memo);
        },
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    Future(() async {
      // ストアからMemoリストデータをロードし画面を更新
      setState(() {
        _store.load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40.0,
            horizontal: 50.0,
          ),
          child: ListView.builder(
            itemCount: _store.count(),
            itemBuilder: (context, index) {
              // インデックスに対応するTodoを取得する
              var item = _store.findByIndex(index);
              return Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          _store.delete(item);
                        });
                      },
                      backgroundColor: Colors.red,
                      icon: FontAwesomeIcons.solidTrashCan,
                      label: '削除',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    _pushMemoInputPage(item);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.only(
                      bottom: 40.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        item.text,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      // Todo追加画面に遷移するボタン
      floatingActionButton: FloatingActionButton(
        // Todo追加画面に遷移する
        onPressed: _pushMemoInputPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
