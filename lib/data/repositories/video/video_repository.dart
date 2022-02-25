
import 'package:youtube_player/data/model/video.dart';

import '../../provider/database_provider.dart';

abstract class VideoRepository {

  DatabaseProvider? databaseProvider;

  Future<void> insert(Video video);

  Future<List<Video>> getVideos();
}