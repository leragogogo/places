import 'package:image_picker/image_picker.dart';
import 'package:places/data/model/categories.dart';

class AddSightRepository {
  List<XFile?> images = [];
  Categories? candidateCategory;
  Categories? activeCategory;
  String? name;
  double? lat;
  double? lon;
  String? details;
}
