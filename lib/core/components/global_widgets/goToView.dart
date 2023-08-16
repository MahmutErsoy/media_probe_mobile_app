// ignore_for_file: file_names

import 'package:flutter/material.dart';

goToView(BuildContext context, Widget view) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => view));
}
