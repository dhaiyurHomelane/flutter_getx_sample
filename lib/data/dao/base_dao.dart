abstract class BaseDao<T> {
  String get createTableQuery;
  T fromMap(Map<String, dynamic> query);
  List<T> fromList(List<Map<String, dynamic>> query);
  Map<String, dynamic> toMap(T object);
}
