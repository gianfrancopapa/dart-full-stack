import 'package:flutter/material.dart';

void bootstrap(Future<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(await builder());
}
