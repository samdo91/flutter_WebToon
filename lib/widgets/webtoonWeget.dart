import 'package:flutter/material.dart';
import 'package:manatoki/screens/ditailScreen.dart';

class Webtoon extends StatelessWidget {
  final String title, id, thumb;

  const Webtoon({
    super.key,
    required this.title,
    required this.id,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector는 동작을 감지해준다.
      onTap: () {
        // Navigator는 화면 전환을 관리하는 클래스입니다.
        Navigator.push(
          context, // 현재 화면의 BuildContext를 사용합니다.

          // MaterialPageRoute은 화면 전환의 애니메이션을 제공합니다.
          MaterialPageRoute(
              builder: (context) => DitailScreen(
                    // 새로운 화면을 생성합니다.
                    title: title, // 새 화면에 전달할 데이터들을 지정합니다.
                    id: id,
                    thumb: thumb,
                  ),
              fullscreenDialog: true),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Hero(
                  tag: id,
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
                      thumb,
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
