import 'package:youtube_player/data/model/video.dart';

import 'base_dao.dart';

class VideoDao extends BaseDao<Video>
{
  final tableName = 'video';
  final _name = 'name';
  final _description = 'description';
  final _imageUrls = 'imageUrls';
  final _videoUrls = 'videoUrls';
  final _channelName='channelName';
  final _channelThumb='channelThumb';
  final _duration='duration';


  @override
  String get createTableQuery => "CREATE TABLE $tableName("
      " $_name TEXT,"
      " $_description TEXT,"
      " $_imageUrls TEXT,"
      " $_channelName TEXT,"
      " $_channelThumb TEXT,"
      " $_duration TEXT,"
      " $_videoUrls TEXT)";

  @override
  List<Video> fromList(List<Map<dynamic, dynamic>> query) {
    List<Video> videos = [];
    for (Map map in query) {
      videos.add(fromMap(map));
    }
    return videos;
  }

  @override
  Video fromMap(Map<dynamic, dynamic> query) {
    Video video = Video();
    video.name=query[_name];
    video.description = query[_description];
    video.imageUrls = query[_imageUrls];
    video.videoUrls = query[_videoUrls];
    video.channelThumb = query[_channelThumb];
    video.channelName = query[_channelName];
    video.duration = query[_duration];
    return video;
  }

  @override
  Map<String, dynamic> toMap(Video object) {
    return <String, dynamic>{
      _name: object.name,
      _description: object.description,
      _imageUrls: object.imageUrls,
      _videoUrls: object.videoUrls,
      _channelName:object.channelName,
      _channelThumb:object.channelThumb,
      _duration:object.duration
    };
  }
}