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
  }

  Future updateOneItem(int key, Map obj) async {
    box.put(key, obj);
  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }
}
