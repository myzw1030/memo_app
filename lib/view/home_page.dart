import 'package:flutter/material.dart';
import 'package:memo_app/utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // リストのデータ
  List<String> listItems = [];

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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
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
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'メモを入力してね',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
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
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text != '') {
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
                      child: const Text(
                        'save',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: listItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                listItems[index],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // // データを削除
                                listItems.removeAt(index);
                                SharePrefs.setListItems(listItems).then((_) {
                                  setState(() {});
                                });
                              },
                              child: const Icon(
                                Icons.close,
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
    );
  }
}
