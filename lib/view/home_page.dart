import 'package:flutter/material.dart';
import 'package:memo_app/component/card_button.dart';
import 'package:memo_app/utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // リストのデータ
  List<String> listItems = [];
  bool _validate = false;

  final titleController = TextEditingController();
  String title = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  // アプリ起動時に保存したデータを読み込む
  void init() async {
    // インスタンスを取得
    await SharePrefs.setInstance();
    listItems = SharePrefs.getListItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  top: 15.0,
                  right: 15.0,
                  bottom: 3.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            hintText: 'メモを入力してね',
                            errorText: _validate ? 'メモがないよ！' : null,
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 15.0,
                            ),
                          ),
                          controller: titleController,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: CardButton(
                          color: Colors.blue,
                          press: () {
                            if (titleController.text.isEmpty) {
                              _validate = true;
                              setState(() {});
                            } else {
                              _validate = false;
                              title = titleController.text;
                              // リストに追加
                              listItems.add(title);
                              // データを保存
                              SharePrefs.setListItems(listItems).then((_) {
                                setState(() {});
                              });
                              // テキストフィールドの値はクリア
                              titleController.clear();
                            }
                          },
                          icon: Icons.add,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15.0,
                  ),
                  child: ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Text(
                                  listItems[index],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    height: 1.6,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: CardButton(
                                  color: Colors.redAccent,
                                  press: () {
                                    // // データを削除
                                    listItems.removeAt(index);
                                    SharePrefs.setListItems(listItems)
                                        .then((_) {
                                      setState(() {});
                                    });
                                  },
                                  icon: Icons.close,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
