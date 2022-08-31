class Memo {
  // ID
  late int id;

  // テキスト
  late String text;

  // コンストラクタ
  Memo(
    this.id,
    this.text,
  );

  // MemoモデルをMapに変換する（保存時に使用）
  Map toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  // MapをMemoモデルに変換する(読み込み時に使用)
  Memo.fromJson(Map json) {
    id = json['id'];
    text = json['text'];
  }
}
