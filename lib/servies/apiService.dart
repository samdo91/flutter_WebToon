import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:manatoki/models/webtoonDetailModel.dart';
import 'package:manatoki/models/webtoonModel.dart';
import 'package:manatoki/models/webtoontoonEpisodesList.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev"; // API의 기본 주소
  static const String today = "today"; // 오늘의 웹툰 데이터를 가져올 엔드포인트

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> todayToonDataList = [];
    final url = Uri.parse("$baseUrl/$today");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        WebtoonModel toonData = WebtoonModel.fromJson(webtoon);
        todayToonDataList.add(toonData);
      }
      return todayToonDataList;
    }
    throw Error(); // 응답이 성공하지 않았을 때 에러를 던짐
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      final toonDetailData = WebtoonDetailModel.fromJson(webtoon);
      return toonDetailData;
    }

    throw Exception('Failed to load webtoon details');
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
