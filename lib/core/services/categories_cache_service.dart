import 'package:hive_flutter/hive_flutter.dart';

class CategoriesCacheService {
  static const String _boxName = 'productsCacheBox';
  static const String _cacheKey = 'categories';

  static Box get _box => Hive.box(_boxName);

  static Future<void> saveCategories(List<String> categories) async {
    await _box.put(_cacheKey, categories);
  }

  static List<String> getCategories() {
    final cachedData = _box.get(_cacheKey);

    if (cachedData == null) return [];

    return List<String>.from(cachedData);
  }
}
