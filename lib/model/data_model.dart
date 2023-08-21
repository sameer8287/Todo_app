// import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;

  DataModel({
    required this.title,
    required this.description
  });
}