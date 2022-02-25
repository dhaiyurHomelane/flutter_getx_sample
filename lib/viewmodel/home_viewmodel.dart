import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player/data/dao/video_dao.dart';

import '../data/provider/database_provider.dart';
import '../data/repositories/video/video_repository_impl.dart';

class HomeViewModel extends GetxController {
  final _key = 'recentHistory';
  final _getBox = GetStorage();

  DatabaseProvider databaseProvider = DatabaseProvider.get;
  VideoRepositoryImpl? videoRepository;
  var videos = [].obs;
  final _isLoading = false.obs;

  get loading => _isLoading.value;

  @override
  void onInit() {
    videoRepository = VideoRepositoryImpl(databaseProvider);
    _getVideo();
    super.onInit();
  }

  ///Get videos from database
  _getVideo() {
    _isLoading.value = true;
    videoRepository!.getVideos().then((videos) {
      ///if database is empty insert video
      ///else fetch from database
      if (videos.isEmpty) {
        _insertVideo();
      } else {
        this.videos.value = videos;
        _isLoading.value = false;
      }
    });
  }

  ///insert videos to database
  _insertVideo() async {
    var parsedJson = await _loadJsonData();
    await Future.forEach(parsedJson, (element) async {
      await videoRepository!.insert(VideoDao().fromMap(element as Map));
    });
    _getVideo();
  }

  ///read json file from assests
  Future<List<dynamic>> _loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data/video.json');
    List<dynamic> parsedJson = json.decode(jsonText);
    return parsedJson;
  }

  /// save recent search history
  saveRecentSearchHistory(String value) {
    List<dynamic> values = _getBox.read(_key)??[];
    if(!values.contains(value)) {
      values.add(value);
    }
    _getBox.write(_key, values);
  }

  //get recent search history
  List<dynamic> getSearchHistory(){
    return _getBox.read(_key)??[];
  }

  @override
  onClose() {
    super.onClose();
  }
}
