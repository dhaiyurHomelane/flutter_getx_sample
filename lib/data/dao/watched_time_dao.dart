import 'package:youtube_player/data/model/WatchedTime.dart';

import 'base_dao.dart';

class WatchedTimeDao extends BaseDao<WatchedTime> {
  final tableName = 'watchedtime';
  final _videoId = 'videoId';
  final _duration = 'duration';
  final startDate = 'startDate';
  final _startTime = 'startTime';

  @override
  String get createTableQuery => "CREATE TABLE $tableName("
      " $_videoId TEXT,"
      " $_duration INT,"
      " $_startTime INT,"
      " $startDate TEXT)";

  @override
  List<WatchedTime> fromList(List<Map<dynamic, dynamic>> query) {
    List<WatchedTime> watchedTime = [];
    for (Map map in query) {
      watchedTime.add(fromMap(map));
    }
    return watchedTime;
  }

  @override
  WatchedTime fromMap(Map<dynamic, dynamic> query) {
    WatchedTime watchedTime = WatchedTime();
    watchedTime.videoId = query[_videoId];
    watchedTime.duration = query[_duration];
    watchedTime.startTime = query[_startTime];
    watchedTime.startDate = query[startDate];
    return watchedTime;
  }

  @override
  Map<String, dynamic> toMap(WatchedTime object) {
    return <String, dynamic>{
      _videoId: object.videoId,
      startDate: object.startDate,
      _startTime: object.startTime,
      _duration: object.duration
    };
  }
}
