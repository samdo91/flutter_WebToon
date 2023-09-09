# Flutter를 알아보자

- 무언가 라이브러리가 필요할떄는 pub.dev를 들어가라

## 기초

- 모든 것은 widget이다. flutter의 모든것은 widget으로 되어 있다. 블록처럼 위젯에 위젯을 쌓아가며 앱을 만드는 것.
- widget은 외우지 말고 찾아보며 사용하자. https://docs.flutter.dev/development/ui/widgets
- 모든 widget은 build 메서드를 사용해야한다.(build 또한 자동 완성 가능)
- 모든 앱은 CupertinoApp 혹은 MaterialApp 중에 선택해야 하는데, materialapp이 훨씬 보기 좋으니 MaterialApp을 쓰자.
- 모든 화면은 Scaffold(구조)를 가져야 한다.

## 주요 wigets

1. StatelessWidget

- 간단하게 그냥 화면을 띄워주는 역할을 한다.

- StatelessWidget는 사용자 인터페이스의 일부를 나타내는 Widget이먀 이 위젯은 State를 가지지 않으며, 한 번 그려진 후에는 변경할 수 없다. 즉, 한 번 생성되면 그 상태가 변하지 않으며 다시 그려질 필요가 없는 정적인 위젯을 의미한다.

- StatelessWidget는 build 메서드를 구현하여 해당 위젯을 렌더링하는 방법을 결정, 정의하며  
  이 메서드는 위젯이 생성될 때 단 한 번 호출되며, 그 결과로 위젯의 모양과 모양이 결정됩니다. - 즉 변경할 수 없다.  
  StatelessWidget를 사용하면 화면의 일부를 동적으로 업데이트하지 않아도 되는 경우에 유용하다. 변하지 않는 값들을 말한다. 예를 들어, 텍스트, 이미지, 아이콘과 같은 정적인 내용을 표시하는 좋다!

## Fetch API

1. 우선 http가 필요하다. pub.dev에서 다운 받기
2. http 사용법을 알아보자
   get()으로 http를 자동으로 가져올 수 있다.
   get은 프로퍼티로 url을 필요로 한다.
3. url을 만들기 위해서는 Uri.parse 매서드가 필요하다. Uri.parse() 함수는 문자열을 기반으로 하여 URI(Universal Resource Identifier)를 생성하는 Dart의 메서드다
4. 여기서 get을 비동기로 만들어 줘야 한다. 익숙한 async await 문법이다.

```
import 'dart:convert'; // JSON 디코딩을 위해 필요한 패키지
import 'package:http/http.dart' as http; // HTTP 요청을 보내기 위해 필요한 패키지

Future<String> fetchWebtoons() async {
  // 웹툰 데이터를 가져올 URL 정의
  final Uri url = Uri.parse("https://webtoon-crawler.nomadcoders.workers.dev");

  // HTTP GET 요청을 보내고 응답을 기다립니다.
  final response = await http.get(url);

  // HTTP 응답 상태 코드가 200 (성공)인지 확인합니다.
  if (response.statusCode == 200) {
    // JSON 형식의 응답 데이터를 디코딩하여 Dart 객체로 변환합니다.
    final webtoons = jsonDecode(response.body);

    // 웹툰 데이터를 반환합니다.
    return webtoons;
  } else {
    // HTTP 요청이 실패한 경우, 예외를 던집니다.
    throw Exception('Failed to load webtoons');
  }
}

```

## 주요 라이브러리

### url_launcher

### Shared preferences

핸드폰 저장소에 데이터를 담을 수 있다.

## 각종 widget 정리

### 위젯 정리 예시

1. (숫자로 번호를 매기고) onVerticalDragDown:(함수, 위젯, 콜백의 이름을 적는다.)

기능:( 위에 적힌 함수, 위젯, 콜백의 기능을 제시하기 전에 "기능" 이라고 적어 알려준다. ) 사용자가 위아래로 스와이프 동작을 시작할 때 호출됩니다.(기능을 설명한다.)

### GestureDetector

- GestureDetector는 사용자의 동작을 감지하고 처리하는 위젯입니다. 다양한 동작을 감지하여 설정된 콜백 함수를 호출합니다. 마우스 이동, 탭(클릭), 드래그

#### 주요 동작과 해당 콜백

1. onTap:

- 기능: 사용자가 위젯을 탭할 때 호출됩니다.

2. onDoubleTap:

- 기능: 사용자가 위젯을 더블 탭할 때 호출됩니다.

3. onLongPress:

- 기능: 사용자가 위젯을 길게 누를 때 호출됩니다.

4. onVerticalDragDown:

- 기능: 사용자가 위아래로 스와이프 동작을 시작할 때 호출됩니다.

5. onScaleStart, onScaleUpdate, onScaleEnd:

- 기능: 핀치 동작(손가락으로 확대/축소)을 처리합니다.

### Navigator

Navigator는 앱 내에서 화면 간 전환을 관리하는 위젯입니다. Navigator를 사용하면 화면을 전환하고, 뒤로 가고, 특정 화면으로 이동할 수 있습니다. 또한, Navigator는 콜백을 제공하여 화면 전환에 대한 추가적인 제어를 할 수 있습니다.

#### 주요 기능

1. Navigator.push():

- 기능: 화면 전환, 사용자가 위젯을 탭할 때 호출됩니다.

2. Navigator.pop():

- 기능: 뒤로 가기, 뒤로 가기 버튼을 누르는 것처럼 이전 화면으로 돌아갑니다.

3. Navigator.pushAndRemoveUntil():

- 기능: 특정 화면으로 이동, 특정 화면으로 이동하면서 이전의 화면들을 모두 제거합니다.

4. Navigator.popUntil():

- 기능: 특정 화면으로 돌아가기, 지정된 화면으로 돌아가기 위해 이전 화면들을 제거합니다.

#### 콜백

1. onGenerateRoute():

- 기능: 라우팅 경로를 동적으로 생성하는 콜백입니다. 앱에서 정의되지 않은 경로에 대한 처리를 위한 콜백입니다.

2. onUnknownRoute():

- 기능: 앱에서 정의되지 않은 경로에 대한 처리를 위한 콜백입니다.

3. onGenerateInitialRoutes():

- 기능: 앱이 시작될 때 생성되는 초기 라우트를 설정합니다.

### MaterialPageRoute

MaterialPageRoute는 Flutter에서 화면을 전환하는 데 사용되는 클래스입니다. 이 클래스는 다음과 같은 중요한 속성과 메서드를 가지고 있습니다:

#### 메서드

1.  builder:

기능: 새로운 화면의 레이아웃을 정의합니다. 일반적으로 BuildContext를 매개변수로 받아 해당 화면을 반환합니다. 제일 중요하다.

2. settings:

   기능: 화면 전환에 대한 설정을 제공하는 RouteSettings 객체입니다. 주로 경로 이름 및 인수를 포함하는데 사용됩니다.

3. fullscreenDialog:

   기능: 화면을 전체 화면 다이얼로그로 표시할지 여부를 나타내는 부울 값입니다.

4. buildTransitions():

   기능: 화면 전환 애니메이션을 빌드합니다. 기본적으로 이 메서드는 화면이 오른쪽에서 왼쪽으로 슬라이딩되는 표준 애니메이션을 생성합니다.

5. canTransitionFrom():

   기능: 현재 화면에서 새로운 화면으로 전환할 수 있는지 여부를 나타내는 부울 값을 반환합니다.

6. canTransitionTo():

   기능: 새로운 화면에서 현재 화면으로 전환할 수 있는지 여부를 나타내는 부울 값을 반환합니다.

7. didAdd():

   기능: 화면이 화면 스택에 추가되었을 때 호출됩니다.

8. didComplete():

   기능: 화면 전환 애니메이션이 완료되었을 때 호출됩니다.

9. didPop():

   기능: 화면이 팝되어 화면 스택에서 제거되었을 때 호출됩니다.

10. didPush():

    기능: 화면이 화면 스택에 추가되었을 때 호출됩니다.

11. willPop():

    기능: 뒤로 가기 버튼이 눌렸을 때 호출되어 화면이 팝되는지 여부를 나타내는 부울 값을 반환합니다.

12. willHandlePopInternally():

    기능: 뒤로 가기 버튼 이벤트가 내부에서 처리되어야 하는지 여부를 나타내는 부울 값을 반환합니다.

13. willPopScope():

    기능: 뒤로 가기 버튼 이벤트를 처리하고 팝을 수행합니다.
