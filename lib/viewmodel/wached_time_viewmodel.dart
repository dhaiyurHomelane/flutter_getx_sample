import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:youtube_player/data/model/WatchedTime.dart';
import 'package:youtube_player/viewmodel/setting_viewmodel.dart';

import '../data/model/graph_model.dart';
import '../data/provider/database_provider.dart';
import '../data/repositories/watchedtime/watchedtime_repository_impl.dart';

class WatchedTimeViewModel extends GetxController {
  DatabaseProvider databaseProvider = DatabaseProvider.get;
  WatchedTimeRepositoryImpl? watchedTimeRepositoryImpl;

  List<WatchedTime> watchedTimeList = <WatchedTime>[];
  var graphData = <charts.Series<GraphModel, String>>[];

  DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  String selectedDay = "Today";
  var dropdownList = ['Today', 'Yesterday', 'Select Date'];

  var currentSelectedSlot = 2.obs;

  ///get data based on dropdown value
  void setSelected(String value) {
    selectedDay = value;
    if (value == 'Today') {
      getWatchedTime(dateFormatter.format(DateTime.now()));
    } else if (selectedDay == 'Yesterday') {
      getWatchedTime(dateFormatter
          .format(DateTime.now().subtract(const Duration(days: 1))));
    } else if (selectedDay == 'Select Date') {
      showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000, 1),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        getWatchedTime(dateFormatter.format(pickedDate!));
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    watchedTimeRepositoryImpl = WatchedTimeRepositoryImpl(databaseProvider);
    getWatchedTime(dateFormatter.format(DateTime.now()));
  }

  ///get watched data from database
  getWatchedTime(String startTime) {
    watchedTimeRepositoryImpl!.getWatchedTime(startTime).then((value) {
      watchedTimeList = value;
      timeGraphSlot(currentSelectedSlot.value);
    });
  }

  ///update chat based on data
  updateGraphData(List<GraphModel> graphDataList) {
    graphData = createSampleData(graphDataList);
    update();
  }

  ///create graph series based on data
  List<charts.Series<GraphModel, String>> createSampleData(
      List<GraphModel> graphDataList) {
    return [
      charts.Series<GraphModel, String>(
        id: 'watchedTime',
        colorFn: (_, __) => SettingViewModel().isDarkMode
            ? charts.MaterialPalette.purple.shadeDefault
            : charts.MaterialPalette.pink.shadeDefault,
        domainFn: (GraphModel sales, _) {
          return sales.title;
        },
        measureFn: (GraphModel sales, _) => sales.duration,
        data: graphDataList,
      )
    ];
  }

  ///create time slot from 24 hours
  timeGraphSlot(int numberOfSlot) {
    currentSelectedSlot.value = numberOfSlot;
    List<GraphModel> graphDataList = [];

    for (int i = 0; i < 24; i++) {
      if (i % numberOfSlot == 0) {
        String title = '$i-${i + numberOfSlot}';
        List<WatchedTime> list = watchedTimeList
            .where((element) =>
                element.startTime! >= i &&
                element.startTime! < (i + numberOfSlot))
            .toList();
        int totalDuration = 0;
        for (var element in list) {
          totalDuration = totalDuration + element.duration!;
        }
        GraphModel graphModel = GraphModel(title, totalDuration);
        graphDataList.add(graphModel);
      }
    }
    updateGraphData(graphDataList);
  }
}
