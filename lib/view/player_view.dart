import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../viewmodel/player_viewmodel.dart';

class PlayerView extends GetView<PlayerViewModel> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller.playerController!,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: Theme.of(context).colorScheme.secondary,
          handleColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).primaryColor,
          bufferedColor: Theme.of(context).colorScheme.primary,
        ),
        onEnded: (metadata) {
          controller.playNextVideo();
        },
        bottomActions: [
          InkWell(
            onTap: () {
              controller.playPreviousVideo();
            },
            child:
                const Icon(Icons.skip_previous, size: 30, color: Colors.white),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              controller.playNextVideo();
            },
            child: const Icon(
              Icons.skip_next,
              size: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          CurrentPosition(),
          const SizedBox(
            width: 10,
          ),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              backgroundColor: context.theme.colorScheme.secondary,
              playedColor: context.theme.colorScheme.primary,
              handleColor: context.theme.colorScheme.primary,
            ),
          ),
          const PlaybackSpeedButton(),
          FullScreenButton(),
        ],
        topActions: [
          Obx(() {
            return Expanded(
              child: Slider(
                  inactiveColor: context.theme.colorScheme.secondary,
                  value: controller.volume.value,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  label: '${(controller.volume.value).round()}',
                  onChanged: (value) {
                    controller.volume.value = value;
                    controller.setVolume();
                  }),
            );
          }),
        ],
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Text(
              'Player',
              style: GoogleFonts.poppins(
                  textStyle: context.textTheme.headlineLarge),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(child: Column(
                children: [
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        controller.videos[controller.currentIndex.value].name,
                        style: GoogleFonts.poppins(
                            textStyle: context.textTheme.bodyText2,
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  }),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        controller
                            .videos[controller.currentIndex.value].description,
                        style: GoogleFonts.poppins(
                            textStyle: context.textTheme.bodyText2),
                      ),
                    );
                  })
                ],
              ),)

            ],
          ),
        );
      },
    );
  }
}
