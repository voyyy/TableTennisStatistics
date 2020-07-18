class Match {
  String id;
  DateTime date;
  Map result;
  var setResult = [];

  var images = [
    {'rl': "http://example.com/image1"},
    {'url': "http://example.com/image2"},
    {'url': "http://example.com/image3"},
  ];

  Match({this.id, this.date, this.result, this.setResult});

  Match.fromMap(Map snapshot, String id)
      : id = id ?? '',
        date = snapshot['date'].toDate() ?? '',
        result = snapshot['result'] ?? '',
        setResult = snapshot['setResult'] ?? '';

  toJson() {
    return {
      "date": date,
      "result": result,
      "setResult": setResult,
    };
  }
}
