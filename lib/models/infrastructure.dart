import 'package:flutter/foundation.dart';


@immutable
class Infrastructure {

  const Infrastructure({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory Infrastructure.fromJson(Map<String,dynamic> json) => Infrastructure(
    id: json['id'] as String,
    title: json['title'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title
  };

  Infrastructure clone() => Infrastructure(
    id: id,
    title: title
  );


  Infrastructure copyWith({
    String? id,
    String? title
  }) => Infrastructure(
    id: id ?? this.id,
    title: title ?? this.title,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Infrastructure && id == other.id && title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
