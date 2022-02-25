
import 'package:youtube_player/data/dao/video_dao.dart';
import 'package:youtube_player/data/model/video.dart';

import '../../provider/database_provider.dart';
import 'video_repository.dart';

class VideoRepositoryImpl extends VideoRepository
{
  final dao = VideoDao();

  VideoRepositoryImpl(this.databaseProvider);

  @override
  DatabaseProvider? databaseProvider;

  @override
  Future<List<Video>> getVideos() async{
    final db = await databaseProvider?.db();
    List<Map<dynamic,dynamic>> maps = (await db?.rawQuery('SELECT * FROM ${dao.tableName}'))!.cast<Map>();
    return dao.fromList(maps);
  }

  @override
  Future<void> insert(Video video) async{
    final db = await databaseProvider?.db();
    try {
      await db?.insert(dao.tableName, dao.toMap(video));
    } catch (e) {
      print(e);
    }
  }
}