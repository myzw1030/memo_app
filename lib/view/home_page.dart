import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memo_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  String title = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  // アプリ起動時に保存したデータを読み込む
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      title = prefs.getString(kTitleKey) ?? '';
    });
  }

  // メモリストのデータ
  List<String> memoList = [];
  // String _text = '';

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
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        // データを保存
                        prefs.setString(kTitleKey, titleController.text);
                        setState(() {
                          // データを読み込む
                          title = prefs.getString(kTitleKey) ?? '';
                          memoList.add(title);
                        });
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
                  itemCount: memoList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                memoList[index],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                // データを保存
                                prefs.setString(
                                    kTitleKey, titleController.text);
                                setState(() {
                                  // データを読み込む
                                  // title = prefs.getString(kTitleKey) ?? '';
                                  // memoList.add(title);
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
