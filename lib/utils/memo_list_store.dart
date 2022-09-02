import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:memo_app/utils/memo.dart';

// memoを取得/追加/更新/削除/保存/読み込み
class MemoListStore {
  // 保存時のキー
  final String _saveKey = 'Memo';

  // Memoリスト
  List<Memo> _list = [Memo(0, '')];

  // ストアのインスタンス
  static final MemoListStore _instance = MemoListStore._internal();

  // プライベートコンストラクタ
  MemoListStore._internal();

  // ファクトリーコンストラクタ
  factory MemoListStore() {
    return _instance;
  }

  // Memoの件数を取得
  int count() {
    return _list.length;
  }

  // 指定したインデックスのMemoを取得する
  Memo findByIndex(int index) {
    return _list[index];
  }

  // Memoを追加する
  void add(String text) {
    final id = count() == 0 ? 1 : _list.last.id + 1;
    final memo = Memo(id, text);
    // _list.add(memo);
    // 先頭へ追加
    _list.insert(0, memo);
    save();
  }

  // Memoを更新する
  void update(Memo memo, [String? text]) {
    if (text != null) {
      memo.text = text;
    }
    save();
  }

  // Memoを削除する
  void delete(Memo memo) {
    _list.remove(memo);
    save();
  }

  // Memoを保存する
  void save() async {
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferencesはプリミティブ型とString型リストしか扱えないため、以下の変換を行っている
    // TodoList形式 → Map形式 → JSON形式 → StringList形式
    final saveTargetList = _list.map((a) => json.encode(a.toJson())).toList();
    prefs.setStringList(_saveKey, saveTargetList);
  }

  //  Memoを読み込み
  void load() async {
    final prefs = await SharedPreferences.getInstance();
    final loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _list = loadTargetList.map((e) => Memo.fromJson(json.decode(e))).toList();
  }
}
