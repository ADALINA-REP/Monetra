import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app/app.dart';
import 'data/repositories/finance_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Desktop FFI initialization for Windows, Linux, and macOS
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Ensure rich sample data is populated if empty or upgrade old basic seed
  final repo = FinanceRepository();
  await repo.seedInitialData();

  runApp(
    const ProviderScope(
      child: MonetraApp(),
    ),
  );
}
