import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player/viewmodel/setting_viewmodel.dart';

import 'watch_time_view.dart';

class SettingView extends GetView<SettingViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Settings',
          style:
              GoogleFonts.poppins(textStyle: context.textTheme.headlineLarge),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: GoogleFonts.poppins(
                          textStyle: context.textTheme.bodyText2),
                    ),
                    Obx(
                      () => Switch(
                          onChanged: (val) => controller.switchTheme(),
                          value: controller.isDarkMode),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => WatchTimeView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Text(
                      'Time Watched',
                      style: GoogleFonts.poppins(
                          textStyle: context.textTheme.bodyText2),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
