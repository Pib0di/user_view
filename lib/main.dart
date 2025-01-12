import 'package:flutter/material.dart';
import 'package:user_view/core/dependencies/provider_scope.dart';
import 'package:user_view/ui/app.dart';

void main() {
  runApp(
    ProviderScope(child: const MyApp()),
  );
}
