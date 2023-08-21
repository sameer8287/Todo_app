import 'package:hiivee_tutorial/model/data_model.dart';
import'package:hive/hive.dart';


class Boxes{
  static Box<DataModel> getData() => Hive.box<DataModel>('notes');
}