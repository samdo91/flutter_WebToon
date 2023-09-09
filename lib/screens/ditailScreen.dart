import 'package:flutter/material.dart';
import 'package:manatoki/models/webtoonDetailModel.dart';
import 'package:manatoki/models/webtoontoonEpisodesList.dart';
import 'package:manatoki/servies/apiService.dart';
import 'package:manatoki/widgets/episodeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DitailScreen extends StatefulWidget {
  final String title, id, thumb;

  const DitailScreen(
      {super.key, required this.title, required this.id, required this.thumb});

  @override
  State<DitailScreen> createState() => _DitailScreenState();
}

class _DitailScreenState extends State<DitailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  bool favoriteIconState = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPref();
  }

  void onfavoriteIcons() async {
    final likedToons = prefs.getStringList('likedToons');
    if (favoriteIconState == true) {
      likedToons!.remove(widget.id);
      favoriteIconState = false;
    } else {
      likedToons!.add(widget.id);
      favoriteIconState = true;
    }
    await prefs.setStringList('likedToons', likedToons);
    setState(() {});
  }

  Future initPref() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        favoriteIconState = true;
        setState(() {});
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 6, // 그림자 두께를 조절합니다.
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal.shade400,
        actions: [
          IconButton(
            onPressed: onfavoriteIcons,
            icon: favoriteIconState
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border_outlined),
          )
        ],
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.teal.shade400,
              fontWeight: FontWeight.w500,
              fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.3),
                          )
                        ],
                      ),
                      child: Image.network(
                        widget.thumb,
                        headers: const {
                          "User-Agent":
                              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.about,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '${snapshot.data!.genre} / ${snapshot.data!.age}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          webtoonEpContainer(
                            episode: episode,
                            webtoonId: widget.id,
                          )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
