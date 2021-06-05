import 'package:flutter/foundation.dart';


@immutable
class Designation {

  const Designation({
    required this.x,
    required this.y,
    required this.label,
  });

  final double x;
  final double y;
  final String label;

  factory Designation.fromJson(Map<String,dynamic> json) => Designation(
    x: json['x'] as double,
    y: json['y'] as double,
    label: json['label'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'label': label
  };

  Designation clone() => Designation(
    x: x,
    y: y,
    label: label
  );


  Designation copyWith({
    double? x,
    double? y,
    String? label
  }) => Designation(
    x: x ?? this.x,
    y: y ?? this.y,
    label: label ?? this.label,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Designation && x == other.x && y == other.y && label == other.label;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ label.hashCode;
}
