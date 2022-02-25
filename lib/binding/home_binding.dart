import 'package:get/get.dart';
import 'package:youtube_player/viewmodel/home_viewmodel.dart';
import 'package:youtube_player/viewmodel/player_viewmodel.dart';
import 'package:youtube_player/viewmodel/setting_viewmodel.dart';
import 'package:youtube_player/viewmodel/wached_time_viewmodel.dart';

class HomeBiding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewModel());
    Get.lazyPut<SettingViewModel>(() => SettingViewModel(),fenix: false);
    Get.lazyPut<PlayerViewModel>(() => PlayerViewModel(),fenix: true);
    Get.lazyPut<WatchedTimeViewModel>(() => WatchedTimeViewModel(),fenix: true);


  }
}
