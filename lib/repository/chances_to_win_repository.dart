import 'package:shared_preferences/shared_preferences.dart';

const String ksChancesToWinKey = 'chances_to_win';

abstract class ChancesToWinRepository {
  static ChancesToWinRepository factory() {
    return _SharedPreferencesChancesToWinRepository();
  }

  Future<int> fetch();

  Future<bool> update(int value);
}

class _SharedPreferencesChancesToWinRepository extends ChancesToWinRepository {
  @override
  Future<int> fetch() async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getInt(ksChancesToWinKey);

    if (value == null) {
      value = 1;
      await update(value);
    }

    return value;
  }

  @override
  Future<bool> update(int value) async {
    try {
      var sp = await SharedPreferences.getInstance();
      await sp.setInt(ksChancesToWinKey, value);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
