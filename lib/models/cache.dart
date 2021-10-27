import 'dart:io';

import 'package:skm_services/enums/template_type.dart';
import 'package:skm_services/models/customer.dart';
import 'package:skm_services/models/sketch_template.dart';

class Cache {
  Customer customer = Customer();
  Map<TemplateType, SketchTemplate> sketch = Map();
  List<File> files = [];
}