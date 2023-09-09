class WebtoonDetailModel {
  final String title;
  final String about;
  final String genre;
  final String age;

  WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });

  factory WebtoonDetailModel.fromJson(Map<String, dynamic> json) {
    return WebtoonDetailModel(
      title: json['title'],
      about: json['about'],
      genre: json['genre'],
      age: json['age'],
    );
  }
}
