import 'package:shared_preferences/shared_preferences.dart';

const String ksCurrentRewardsKey = 'current_rewards';

abstract class CurrentRewardsRepository {
  static CurrentRewardsRepository factory() {
    return _SharedPreferencesCurrentRewardsRepository();
  }

  Future<int> fetch();

  Future<bool> update(int value);
}

class _SharedPreferencesCurrentRewardsRepository extends CurrentRewardsRepository {
  @override
  Future<int> fetch() async {
    var sp = await SharedPreferences.getInstance();
    var value = sp.getInt(ksCurrentRewardsKey);

    if (value == null) {
      value = 0;
      await update(value);
    }

    return value;
  }

  @override
  Future<bool> update(int value) async {
    try {
      var sp = await SharedPreferences.getInstance();
      await sp.setInt(ksCurrentRewardsKey, value);
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
