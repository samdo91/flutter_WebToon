import 'package:flutter/material.dart';
import 'package:manatoki/models/webtoonModel.dart';
import 'package:manatoki/servies/apiService.dart';
import 'dart:io';

import 'package:manatoki/widgets/webtoonWeget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

// 'ApiService.getTodaysToon()' 메서드는 오늘의 웹툰 정보를 가져오는 비동기 함수입니다.
// 이 함수는 Future<List<WebtoonModel>>을 반환합니다.
// 이 Future는 언젠가는 웹툰 정보를 포함하게 될 것입니다.
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 6, // 그림자 두께를 조절합니다.
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Text(
          "Today's Toon!",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.teal.shade400,
              fontWeight: FontWeight.w500,
              fontSize: 22),
        ),
      ),
      body: FutureBuilder(
        // 'webtoons' 변수는 ApiService.getTodaysToon()에서 반환된 Future입니다.
        future: webtoons, // 이걸 Future에 사용한다.
        builder: (context, snapshot) {
          // 'snapshot'은 비동기 작업의 현재 상태와 결과를 담고 있습니다.

          // 'hasData'는 데이터가 성공적으로 로드되었는지 확인합니다.
          if (snapshot.hasData) {
            // 데이터가 로드되면 "성공!"이라는 텍스트를 반환합니다.
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: webtoonListView(data: snapshot.data!)), // 데이터 전달
              ],
            );
          }

          // 데이터가  로드되지 않았다면 로딩중을 만들어주는 위젯 사용
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class webtoonListView extends StatelessWidget {
  final List<WebtoonModel> data;
  const webtoonListView({super.key, Key, required this.data});

// 데이터를 받을 변수 추가

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // ListView.separated를 사용하여 가로로 스크롤되는 목록을 생성합니다.
      scrollDirection: Axis.horizontal,

      // 'snapshot.data!.length'는 현재 데이터에 포함된 웹툰의 총 개수입니다.
      itemCount: data.length, // 'data' 변수에 있는 데이터를 사용

      // 'itemBuilder'는 각 아이템을 생성하는 함수입니다.
      itemBuilder: (context, index) {
        // 'snapshot.data![index]'를 사용하여 현재 인덱스에 해당하는 웹툰 데이터를 가져옵니다.
        var webtoon = data[index];

        return Webtoon(
          title: webtoon.title,
          id: webtoon.id,
          thumb: webtoon.thumb,
        );
      },

      // 'separatorBuilder'는 각 아이템 사이에 추가되는 구분자를 정의합니다.
      // 여기서는 간격을 두기 위해 가로로 20픽셀의 공간을 추가합니다.
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
