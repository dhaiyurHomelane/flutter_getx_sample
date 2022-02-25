import 'package:get/get.dart';
import 'package:youtube_player/data/model/WatchedTime.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

import '../data/provider/database_provider.dart';
import '../data/repositories/watchedtime/watchedtime_repository_impl.dart';

class PlayerViewModel extends GetxController {
  DatabaseProvider databaseProvider = DatabaseProvider.get;
  WatchedTimeRepositoryImpl? watchedTimeRepositoryImpl;

  YoutubePlayerController? playerController;
  var videos = Get.arguments[0]['video'];
  var index = Get.arguments[1]['index'];

  DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  DateFormat timeFormatter = DateFormat('HH');

  var currentIndex = 0.obs;
  var volume = 100.0.obs;

  DateTime? startDateTime;
  bool isPlaying = false;

  @override
  void onInit() {
    super.onInit();
    watchedTimeRepositoryImpl = WatchedTimeRepositoryImpl(databaseProvider);

    currentIndex.value = index;
    playerController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(videos[currentIndex.value].videoUrls)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideControls: false,
        enableCaption: false,
      ),
    )..addListener(listener);
  }

  ///youtube video listener
  ///manage watched time using listeners
  listener() {
    if (playerController!.value.playerState == PlayerState.playing) {
      if (startDateTime == null) {
        startDateTime = DateTime.now();
        isPlaying = true;
      }
    } else if (playerController!.value.playerState == PlayerState.paused) {
      if (startDateTime != null && isPlaying) {
        isPlaying = false;
        int difference =
            startDateTime!.difference(DateTime.now()).inSeconds.abs();
        startDateTime = null;
        insertWatchedTime(
            playerController!.metadata.videoId,
            dateFormatter.format(DateTime.now()),
            timeFormatter.format(DateTime.now()),
            difference);
      }
    } else if (playerController!.value.playerState == PlayerState.ended) {
      if (startDateTime != null) {
        isPlaying = false;
        int difference =
            startDateTime!.difference(DateTime.now()).inSeconds.abs();
        startDateTime = null;
        insertWatchedTime(
            playerController!.metadata.videoId,
            dateFormatter.format(DateTime.now()),
            timeFormatter.format(DateTime.now()),
            difference);
      }
    }
  }

  bool get hasNext => currentIndex.value + 1 < videos.length;

  bool get hasPrevious => currentIndex.value > 0;

  @override
  void onClose() {
    if (startDateTime != null) {
      int difference =
          startDateTime!.difference(DateTime.now()).inSeconds.abs();
      startDateTime = null;
      insertWatchedTime(
          playerController!.metadata.videoId,
          dateFormatter.format(DateTime.now()),
          timeFormatter.format(DateTime.now()),
          difference);
    }
    playerController!.dispose();
    super.onClose();
  }

  ///set volume
  setVolume() {
    playerController!.setVolume(volume.value.round());
  }

  ///play next video
  playNextVideo() {
    if (hasNext) {
      currentIndex.value++;
      playerController!.load(
          YoutubePlayer.convertUrlToId(videos[currentIndex.value].videoUrls)!);
    }
  }

  ///play previous video
  playPreviousVideo() {
    if (hasPrevious) {
      currentIndex.value--;
      playerController!.load(
          YoutubePlayer.convertUrlToId(videos[currentIndex.value].videoUrls)!);
    }
  }

  ///insert watched time record
  insertWatchedTime(
      String videoId, String startDate, String startTime, int duration) {
    WatchedTime watchedTime = WatchedTime();
    watchedTime.videoId = videoId;
    watchedTime.startDate = startDate;
    watchedTime.duration = duration;
    watchedTime.startTime = int.parse(startTime);
    watchedTimeRepositoryImpl!.insert(watchedTime);
  }
}
