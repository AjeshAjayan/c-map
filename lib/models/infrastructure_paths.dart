import 'package:flutter/foundation.dart';


@immutable
class InfrastructurePaths {

  const InfrastructurePaths({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.startLabel,
    required this.endLabel,
  });

  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final String startLabel;
  final String endLabel;

  factory InfrastructurePaths.fromJson(Map<String,dynamic> json) => InfrastructurePaths(
    startX: json['startX'] as double,
    startY: json['startY'] as double,
    endX: json['endX'] as double,
    endY: json['endY'] as double,
    startLabel: json['startLabel'] as String,
    endLabel: json['endLabel'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'startX': startX,
    'startY': startY,
    'endX': endX,
    'endY': endY,
    'startLabel': startLabel,
    'endLabel': endLabel
  };

  InfrastructurePaths clone() => InfrastructurePaths(
    startX: startX,
    startY: startY,
    endX: endX,
    endY: endY,
    startLabel: startLabel,
    endLabel: endLabel
  );


  InfrastructurePaths copyWith({
    double? startX,
    double? startY,
    double? endX,
    double? endY,
    String? startLabel,
    String? endLabel
  }) => InfrastructurePaths(
    startX: startX ?? this.startX,
    startY: startY ?? this.startY,
    endX: endX ?? this.endX,
    endY: endY ?? this.endY,
    startLabel: startLabel ?? this.startLabel,
    endLabel: endLabel ?? this.endLabel,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is InfrastructurePaths && startX == other.startX && startY == other.startY && endX == other.endX && endY == other.endY && startLabel == other.startLabel && endLabel == other.endLabel;

  @override
  int get hashCode => startX.hashCode ^ startY.hashCode ^ endX.hashCode ^ endY.hashCode ^ startLabel.hashCode ^ endLabel.hashCode;
}
