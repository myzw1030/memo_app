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
  // リストのデータ
  // List<String> listItems = [''];

  // final titleController = TextEditingController();
  // String title = '';
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
          padding: const EdgeInsets.all(20.0),
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
                      icon: FontAwesomeIcons.solidTrashCan,
                      label: '削除',
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(CustomPageRoute(
                    //   const MemoInputPage(),
                    // ));
                    _pushMemoInputPage(item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(
                          4.0,
                        ),
                      ),
                      child: ListTile(
                        leading: Text(item.id.toString()),
                        title: Text(item.text),
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
