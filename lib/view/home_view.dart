import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player/view/player_view.dart';
import 'package:youtube_player/view/setting_view.dart';
import 'package:youtube_player/view/widget/video_card.dart';
import 'package:youtube_player/view/widget/video_search.dart';

import '../data/model/video.dart';
import '../viewmodel/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeViewModel controller=Get.find();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leadingWidth: 70,
        leading: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Image.asset(
            'assets/images/youtube.png',
            fit: BoxFit.fill,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () async {
                showSearch(
                    context: context,
                    delegate: VideoSearch());
              },
              child: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                //controller.saveRecentSearchHistory(value)
                Get.to(() => SettingView());
              },
              child: const Icon(
                Icons.supervised_user_circle,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: controller.loading?const Center(child: CircularProgressIndicator()):ListView.separated(
                  itemCount: controller.videos.length,
                  itemBuilder: (context, index) {
                    Video video = controller.videos[index];
                    return InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.to(() => PlayerView(), arguments: [
                            {"video": controller.videos},
                            {"index": index}
                          ]);
                        },
                        child: VideoCard(video: video));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 30,
                    );
                  },
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
