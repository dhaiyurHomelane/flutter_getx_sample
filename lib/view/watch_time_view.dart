import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../viewmodel/setting_viewmodel.dart';
import '../viewmodel/wached_time_viewmodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WatchTimeView extends GetView<WatchedTimeViewModel> {
  @override
  Widget build(BuildContext context) {
    var settingController = Get.find<SettingViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Time Watched',
          style:
              GoogleFonts.poppins(textStyle: context.textTheme.headlineLarge),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GetBuilder<WatchedTimeViewModel>(
              builder: (value) => DropdownButtonFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  filled: true,
                  hintText: "Name",
                ),
                onChanged: (newValue) {
                  controller.setSelected(newValue.toString());
                },
                value: controller.selectedDay,
                items: controller.dropdownList.map((selectedType) {
                  return DropdownMenuItem(
                    child: Text(
                      selectedType,
                    ),
                    value: selectedType,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<WatchedTimeViewModel>(
              builder: (value) => SizedBox(
                height: context.height / 2.5,
                child: charts.BarChart(
                  controller.graphData,
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelRotation: 91,
                      labelStyle: charts.TextStyleSpec(
                          fontSize: 16, // size in Pts.
                          color: settingController.isDarkMode
                              ? charts.MaterialPalette.white
                              : charts.MaterialPalette.black),
                      lineStyle: charts.LineStyleSpec(
                          color: settingController.isDarkMode
                              ? charts.MaterialPalette.white
                              : charts.MaterialPalette.black),
                    ),
                  ),
                  primaryMeasureAxis: charts.NumericAxisSpec(
                    renderSpec: charts.GridlineRendererSpec(
                      labelStyle: charts.TextStyleSpec(
                          fontSize: 16, // size in Pts.
                          color: settingController.isDarkMode
                              ? charts.MaterialPalette.white
                              : charts.MaterialPalette.black),
                      lineStyle: charts.LineStyleSpec(
                          color: settingController.isDarkMode
                              ? charts.MaterialPalette.white
                              : charts.MaterialPalette.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.timeGraphSlot(2);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "2 Hours",
                        style: GoogleFonts.poppins(
                            textStyle: Get.context!.textTheme.bodyText2,
                            color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.timeGraphSlot(4);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "4 Hours",
                        style: GoogleFonts.poppins(
                            textStyle: Get.context!.textTheme.bodyText2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.timeGraphSlot(6);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "6 Hours",
                        style: GoogleFonts.poppins(
                            textStyle: Get.context!.textTheme.bodyText2,
                            color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.timeGraphSlot(8);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "8 Hours",
                        style: GoogleFonts.poppins(
                            textStyle: Get.context!.textTheme.bodyText2,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
