import 'package:flutter/foundation.dart';


@immutable
class Designation {

  const Designation({
    this.infId,
    required this.x,
    required this.y,
    required this.label,
  });

  final int? infId;
  final double x;
  final double y;
  final String label;

  factory Designation.fromJson(Map<String,dynamic> json) => Designation(
    infId: json['inf_id'] != null ? json['inf_id'] as int : null,
    x: json['x'] as double,
    y: json['y'] as double,
    label: json['label'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'inf_id': infId,
    'x': x,
    'y': y,
    'label': label
  };

  Designation clone() => Designation(
    infId: infId,
    x: x,
    y: y,
    label: label
  );


  Designation copyWith({
    int? infId,
    double? x,
    double? y,
    String? label
  }) => Designation(
    infId: infId ?? this.infId,
    x: x ?? this.x,
    y: y ?? this.y,
    label: label ?? this.label,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Designation && infId == other.infId && x == other.x && y == other.y && label == other.label;

  @override
  int get hashCode => infId.hashCode ^ x.hashCode ^ y.hashCode ^ label.hashCode;
}
