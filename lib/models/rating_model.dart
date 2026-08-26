import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  final num rate;
  final num count;

  const RatingModel({required this.rate, required this.count});

  @override
  // TODO: implement props
  List<Object?> get props => [rate, count];

  Map<String, dynamic> toMap() {
    return {
      'rate': this.rate,
      'count': this.count,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      rate: map['rate'] as num,
      count: map['count'] as num,
    );
  }}
