import 'package:flutter/material.dart';
import 'package:manatoki/models/webtoontoonEpisodesList.dart';
import 'package:url_launcher/url_launcher_string.dart';

class webtoonEpContainer extends StatelessWidget {
  const webtoonEpContainer(
      {super.key, required this.episode, required this.webtoonId});

  onButtonGoToEpisodes() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonGoToEpisodes,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade400,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(5, 5),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
