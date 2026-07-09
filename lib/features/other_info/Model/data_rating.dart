import 'package:hive/hive.dart';

part 'data_rating.g.dart';

@HiveType(typeId: 10)
class RatingModel extends HiveObject {

  @HiveField(0)
  final int rating;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime createdAt;

  RatingModel({
    required this.rating,
    required this.message,
    required this.createdAt,
  });
}