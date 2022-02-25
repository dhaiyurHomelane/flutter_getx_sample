import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player/data/model/video.dart';

class VideoCard extends StatelessWidget {
  final Video video;

  VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: video.imageUrls!,
                  placeholder: (context, url) => Image.asset('assets/images/placeholder.png'),
                  errorWidget: (context, url, error) => Image.asset('assets/images/placeholder.png'),
                )),
            Positioned(
                left: 5,
                bottom: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black87,
                  ),
                  child: Text(
                    video.duration!,
                    style: GoogleFonts.poppins(
                        textStyle: Get.context!.textTheme.caption),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                video.name!,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    textStyle: Get.context!.textTheme.bodyText2),
              ),
            ),
            const Icon(Icons.more_horiz)
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(video.channelThumb!),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(
                video.channelName!,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    textStyle: Get.context!.textTheme.bodyText2),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  "SubScribe",
                  style: GoogleFonts.poppins(
                      textStyle: Get.context!.textTheme.bodyText2,
                      color: Colors.white),
                ))
          ],
        ),
      ],
    );
  }
}
