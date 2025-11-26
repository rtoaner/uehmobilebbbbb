// utils.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;
import 'package:sqflite_common/sqlite_api.dart' show Database, DatabaseFactory, OpenDatabaseOptions;

/// NOTE:
/// - On Web: we use an in-memory fallback Map (suitable for dev/testing).
/// - On Desktop: we use sqflite_common_ffi.
/// - On Mobile (Android/iOS): if you want a real DB, switch to `sqflite` package
///   and implement mobile init accordingly.
///
/// This file avoids using `dart:io` Platform APIs so it won't crash on Web.

Database? _db;
DatabaseFactory? _dbFactory;

/// In-memory fallback for web (simple map: email -> user data)
final Map<String, Map<String, dynamic>> _memoryUsers = {};
int _memoryIdCounter = 0;

/// Initialize DB (idempotent).
Future<void> initDB() async {
  if (kIsWeb) {
    // nothing to initialize for the in-memory fallback
    return;
  }

  // Desktop: initialize ffi factory
  if (_db != null && _db!.isOpen) return;

  ffi.sqfliteFfiInit();
  _dbFactory = ffi.databaseFactoryFfi;

  final dbPath = await _dbFactory!.getDatabasesPath();
  final path = join(dbPath, 'users.db');

  _db = await _dbFactory!.openDatabase(
    path,
    options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE,
            password TEXT,
            fullname TEXT,
            className TEXT
          )
        ''');
      },
    ),
  );
}

/// Internal helper: ensure the proper backend is ready.
/// On web it's a no-op (we use in-memory map).
Future<void> _ensureInit() async {
  if (kIsWeb) return;
  await initDB();
}

/// Register user. Returns inserted id (int).
/// Throws if duplicate email.
Future<int> registerUser(Map<String, dynamic> data) async {
  if (kIsWeb) {
    final email = (data['email'] ?? '').toString();
    if (email.isEmpty) throw Exception('Email empty');
    if (_memoryUsers.containsKey(email)) {
      // Simulate UNIQUE constraint violation
      throw Exception('Email already exists');
    }
    _memoryIdCounter++;
    final record = Map<String, dynamic>.from(data);
    record['id'] = _memoryIdCounter;
    _memoryUsers[email] = record;
    return _memoryIdCounter;
  }

  await _ensureInit();
  // will throw if UNIQUE constraint violated
  return await _db!.insert('users', data);
}

/// Login user: returns Map of row or null
Future<Map<String, dynamic>?> loginUser(String email, String password) async {
  if (kIsWeb) {
    final rec = _memoryUsers[email];
    if (rec != null && rec['password'] == password) return rec;
    return null;
  }

  await _ensureInit();
  final res = await _db!.query(
    'users',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );
  if (res.isNotEmpty) return res.first;
  return null;
}

/// Optional helper to close DB (desktop)
Future<void> closeDB() async {
  if (kIsWeb) {
    _memoryUsers.clear();
    _memoryIdCounter = 0;
    return;
  }
  if (_db != null && _db!.isOpen) {
    await _db!.close();
    _db = null;
  }
}
