import 'package:youtube_player/data/model/WatchedTime.dart';

import '../../provider/database_provider.dart';

abstract class WatchedTimeRepository {
  DatabaseProvider? databaseProvider;

  Future<void> insert(WatchedTime watchedTime);

  Future<List<WatchedTime>> getWatchedTime(String startDate);
}
