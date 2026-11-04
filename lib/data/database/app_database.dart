import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/budget_model.dart';
import '../models/category_model.dart';
import '../models/savings_goal_model.dart';
import '../models/subscription_model.dart';
import '../models/transaction_model.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._internal();
  AppDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    // Enable FFI for Windows desktop and unit tests
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String dbPath;
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      final docDir = await getApplicationDocumentsDirectory();
      dbPath = p.join(docDir.path, 'monetra_app.db');
    } else {
      final databasesPath = await getDatabasesPath();
      dbPath = p.join(databasesPath, 'monetra_app.db');
    }

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // 1. Categories Table
    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        icon_code INTEGER NOT NULL,
        color_hex INTEGER NOT NULL,
        type TEXT NOT NULL,
        is_default INTEGER NOT NULL DEFAULT 1
      )
    ''');

    // 2. Transactions Table
    await db.execute('''
      CREATE TABLE transactions (
        id TEXT PRIMARY KEY,
        amount_cents INTEGER NOT NULL,
        type TEXT NOT NULL,
        category_id TEXT NOT NULL,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        notes TEXT,
        is_recurring INTEGER NOT NULL DEFAULT 0,
        recurring_id TEXT
      )
    ''');

    // 3. Budgets Table
    await db.execute('''
      CREATE TABLE budgets (
        id TEXT PRIMARY KEY,
        category_id TEXT,
        name TEXT NOT NULL,
        limit_cents INTEGER NOT NULL,
        period_month TEXT NOT NULL,
        carry_over INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // 4. Savings Goals Table
    await db.execute('''
      CREATE TABLE savings_goals (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        target_amount_cents INTEGER NOT NULL,
        current_amount_cents INTEGER NOT NULL,
        target_date TEXT NOT NULL,
        icon_code INTEGER NOT NULL,
        color_hex INTEGER NOT NULL,
        notes TEXT
      )
    ''');

    // 5. Subscriptions Table
    await db.execute('''
      CREATE TABLE subscriptions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        amount_cents INTEGER NOT NULL,
        billing_cycle TEXT NOT NULL,
        next_billing_date TEXT NOT NULL,
        category_id TEXT NOT NULL,
        icon_code INTEGER NOT NULL,
        color_hex INTEGER NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1
      )
    ''');

    // 6. Settings Table
    await db.execute('''
      CREATE TABLE app_settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');

    // Seed default categories
    for (final cat in CategoryModel.defaultExpenseCategories) {
      await db.insert('categories', cat.toMap());
    }
    for (final cat in CategoryModel.defaultIncomeCategories) {
      await db.insert('categories', cat.toMap());
    }

    // Seed default settings
    await db.insert('app_settings', {'key': 'currency', 'value': 'USD'});
    await db.insert('app_settings', {'key': 'theme_mode', 'value': 'system'});
    await db.insert('app_settings', {'key': 'onboarding_complete', 'value': 'false'});
    await db.insert('app_settings', {'key': 'monthly_income_cents', 'value': '450000'}); // $4,500.00
  }

  // --- Transaction Queries ---
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final maps = await db.query('transactions', orderBy: 'date DESC');
    return maps.map((e) => TransactionModel.fromMap(e)).toList();
  }

  Future<void> insertTransaction(TransactionModel tx) async {
    final db = await database;
    await db.insert('transactions', tx.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    final db = await database;
    await db.update('transactions', tx.toMap(), where: 'id = ?', whereArgs: [tx.id]);
  }

  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  // --- Category Queries ---
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await database;
    final maps = await db.query('categories');
    return maps.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<void> insertCategory(CategoryModel cat) async {
    final db = await database;
    await db.insert('categories', cat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // --- Budget Queries ---
  Future<List<BudgetModel>> getBudgets(String periodMonth) async {
    final db = await database;
    final maps = await db.query('budgets', where: 'period_month = ?', whereArgs: [periodMonth]);
    return maps.map((e) => BudgetModel.fromMap(e)).toList();
  }

  Future<void> saveBudget(BudgetModel budget) async {
    final db = await database;
    await db.insert('budgets', budget.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteBudget(String id) async {
    final db = await database;
    await db.delete('budgets', where: 'id = ?', whereArgs: [id]);
  }

  // --- Savings Goal Queries ---
  Future<List<SavingsGoalModel>> getAllSavingsGoals() async {
    final db = await database;
    final maps = await db.query('savings_goals');
    return maps.map((e) => SavingsGoalModel.fromMap(e)).toList();
  }

  Future<void> saveSavingsGoal(SavingsGoalModel goal) async {
    final db = await database;
    await db.insert('savings_goals', goal.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateGoalContribution(String id, int addedCents) async {
    final db = await database;
    final maps = await db.query('savings_goals', where: 'id = ?', whereArgs: [id], limit: 1);
    if (maps.isNotEmpty) {
      final current = maps.first['current_amount_cents'] as int;
      final updated = (current + addedCents).clamp(0, 999999999);
      await db.update('savings_goals', {'current_amount_cents': updated}, where: 'id = ?', whereArgs: [id]);
    }
  }

  Future<void> deleteSavingsGoal(String id) async {
    final db = await database;
    await db.delete('savings_goals', where: 'id = ?', whereArgs: [id]);
  }

  // --- Subscription Queries ---
  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    final db = await database;
    final maps = await db.query('subscriptions', orderBy: 'next_billing_date ASC');
    return maps.map((e) => SubscriptionModel.fromMap(e)).toList();
  }

  Future<void> saveSubscription(SubscriptionModel sub) async {
    final db = await database;
    await db.insert('subscriptions', sub.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteSubscription(String id) async {
    final db = await database;
    await db.delete('subscriptions', where: 'id = ?', whereArgs: [id]);
  }

  // --- Settings Queries ---
  Future<String?> getSetting(String key) async {
    final db = await database;
    final maps = await db.query('app_settings', where: 'key = ?', whereArgs: [key], limit: 1);
    if (maps.isNotEmpty) {
      return maps.first['value'] as String;
    }
    return null;
  }

  Future<void> setSetting(String key, String value) async {
    final db = await database;
    await db.insert('app_settings', {'key': key, 'value': value}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Exports full database contents into a JSON-encodable map for data portability
  Future<Map<String, dynamic>> exportAllData() async {
    final txs = await getAllTransactions();
    final cats = await getAllCategories();
    final goals = await getAllSavingsGoals();
    final subs = await getAllSubscriptions();

    return {
      'version': 1,
      'exported_at': DateTime.now().toIso8601String(),
      'transactions': txs.map((e) => e.toMap()).toList(),
      'categories': cats.map((e) => e.toMap()).toList(),
      'savings_goals': goals.map((e) => e.toMap()).toList(),
      'subscriptions': subs.map((e) => e.toMap()).toList(),
    };
  }

  /// Restores data from a backup map
  Future<void> restoreAllData(Map<String, dynamic> data) async {
    final db = await database;
    await db.transaction((txn) async {
      if (data.containsKey('transactions')) {
        await txn.delete('transactions');
        for (final item in (data['transactions'] as List)) {
          await txn.insert('transactions', Map<String, dynamic>.from(item as Map));
        }
      }
      if (data.containsKey('savings_goals')) {
        await txn.delete('savings_goals');
        for (final item in (data['savings_goals'] as List)) {
          await txn.insert('savings_goals', Map<String, dynamic>.from(item as Map));
        }
      }
      if (data.containsKey('subscriptions')) {
        await txn.delete('subscriptions');
        for (final item in (data['subscriptions'] as List)) {
          await txn.insert('subscriptions', Map<String, dynamic>.from(item as Map));
        }
      }
    });
  }

  Future<void> clearSampleData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('transactions');
      await txn.delete('budgets');
      await txn.delete('subscriptions');
      await txn.delete('savings_goals');
    });
  }
}
