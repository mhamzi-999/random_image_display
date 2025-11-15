import '../../../../core/error/exceptions.dart';
import '../../domain/entities/random_image.dart';

/// Concrete data model for random images coming from the API.
class RandomImageModel extends RandomImage {
  const RandomImageModel({required super.url});

  factory RandomImageModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String?;
    if (url == null || url.isEmpty) {
      throw const UnexpectedException('Image url is missing');
    }
    return RandomImageModel(url: url);
  }

  Map<String, dynamic> toJson() => {'url': url};
}
