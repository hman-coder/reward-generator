import 'package:shared_preferences/shared_preferences.dart';

const String ksCategoriesKey = 'categories';

abstract class CategoriesRepository {
  Future<List<String>> fetchCategories();

  void add(String category);
}

class SharedPreferencesCategoriesRepository extends CategoriesRepository {
  @override
  Future<List<String>> fetchCategories() async{
    var sp = await SharedPreferences.getInstance();
    return sp.getStringList(ksCategoriesKey);
  }

  @override
  void add(String category) async {
    var sp = await SharedPreferences.getInstance();
    var list = sp.getStringList(ksCategoriesKey);
    list.add(category);
    await sp.setStringList(ksCategoriesKey, list);    
  }
  
}