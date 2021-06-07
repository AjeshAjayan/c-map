import 'package:flutter/foundation.dart';


@immutable
class Infrastructure {

  const Infrastructure({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.isDeleted,
  });

  final String id;
  final String title;
  final String createdDate;
  final String isDeleted;

  factory Infrastructure.fromJson(Map<String,dynamic> json) => Infrastructure(
    id: json['id'] as String,
    title: json['title'] as String,
    createdDate: json['created_date'] as String,
    isDeleted: json['is_deleted'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'created_date': createdDate,
    'is_deleted': isDeleted
  };

  Infrastructure clone() => Infrastructure(
    id: id,
    title: title,
    createdDate: createdDate,
    isDeleted: isDeleted
  );


  Infrastructure copyWith({
    String? id,
    String? title,
    String? createdDate,
    String? isDeleted
  }) => Infrastructure(
    id: id ?? this.id,
    title: title ?? this.title,
    createdDate: createdDate ?? this.createdDate,
    isDeleted: isDeleted ?? this.isDeleted,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Infrastructure && id == other.id && title == other.title && createdDate == other.createdDate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ createdDate.hashCode ^ isDeleted.hashCode;
}
