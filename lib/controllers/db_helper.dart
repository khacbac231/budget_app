import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box("money");
  }

  Future addData(int amount, DateTime date, String note, String type) async {
    var value = {'amount': amount, 'date': date, 'type': type, 'note': note};
    box.add(value);
  }

  Future deleteData(int key) async {
    box.delete(key);
    print("19:----------${box.keys}");
    return fetch();
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      print(box.toMap().toString());
      return Future.value(box.toMap());
    }
  }
}
