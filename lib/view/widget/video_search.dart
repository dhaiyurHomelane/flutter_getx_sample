import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player/data/model/video.dart';
import 'package:youtube_player/view/widget/video_card.dart';
import 'package:youtube_player/viewmodel/home_viewmodel.dart';

import '../player_view.dart';

class VideoSearch extends SearchDelegate<String> {
  List<Video> videos=[];
  List<dynamic> recentSearchHistory=[];
  HomeViewModel homeViewModel = Get.find();

  VideoSearch(){
    videos=homeViewModel.videos.value as List<Video>;
    recentSearchHistory=homeViewModel.getSearchHistory();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query == '') {
            close(context, '');
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
        onTap: () {
          close(context, '');
        },
        child: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query == '') {
      return Container();
    }
    List<Video> search = videos
        .where((element) => element.name!.toLowerCase().contains(query)||element.description!.toLowerCase().contains(query))
        .toList();

    homeViewModel.saveRecentSearchHistory(query.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: search.length,
        itemBuilder: (context, index) {
          Video video = search[index];
          return InkWell(
              onTap: () {
                Get.to(() => PlayerView(), arguments: [
                  {"video": videos},
                  {"index": videos.indexOf(video)}
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: recentSearchHistory.length,
      itemBuilder: (content, index) => ListTile(
          leading: const Icon(Icons.history),
          title: Text(recentSearchHistory[index],
              style: GoogleFonts.poppins(
                  textStyle: Get.context!.textTheme.bodyText2))),
    );
  }
}
