import 'package:UI/core/models/tag.dart';

class Constants {
  static const String API_URL = "///";

  static const String GET_USER = "$API_URL/user/{uuid}";

  static List<Tag> tags = [
    Tag(name: 'Flutter'),
    Tag(name: 'GCP'),
    Tag(name: 'AWS'),
    Tag(name: 'Rust'),
    Tag(name: 'SRE'),
    Tag(name: 'Mobile devlopment'),
    Tag(name: 'Kotlin'),
    Tag(name: 'Java'),
    Tag(name: 'Swift'),
  ];
}
