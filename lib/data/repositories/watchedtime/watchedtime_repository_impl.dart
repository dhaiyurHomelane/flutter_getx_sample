import 'package:youtube_player/data/model/WatchedTime.dart';
import 'package:youtube_player/data/repositories/watchedtime/watchedtime_repository.dart';

import '../../dao/watched_time_dao.dart';
import '../../provider/database_provider.dart';

class WatchedTimeRepositoryImpl extends WatchedTimeRepository {
  final dao = WatchedTimeDao();

  WatchedTimeRepositoryImpl(this.databaseProvider);

  @override
  DatabaseProvider? databaseProvider;

  @override
  Future<void> insert(WatchedTime watchedTime) async {
    final db = await databaseProvider?.db();
    try {
      await db?.insert(dao.tableName, dao.toMap(watchedTime));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<WatchedTime>> getWatchedTime(String startDate) async {
    final db = await databaseProvider?.db();
    List<Map<dynamic,dynamic>> maps = (await db?.rawQuery('SELECT * FROM ${dao.tableName} where ${dao.startDate}=?',[startDate]))!.cast<Map>();
    return dao.fromList(maps);
  }
}
