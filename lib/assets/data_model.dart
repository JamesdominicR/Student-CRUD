import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class ListItem extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? place;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? image;

  ListItem({
    this.name,
    this.place,
    this.phone,
    this.image,
  });
}
