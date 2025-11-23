import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/rental_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('carrent.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        nik TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        address TEXT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE rentals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        carId INTEGER NOT NULL,
        carName TEXT NOT NULL,
        carBrand TEXT NOT NULL,
        carType TEXT NOT NULL,
        carImageUrl TEXT NOT NULL,
        carPricePerDay REAL NOT NULL,
        renterName TEXT NOT NULL,
        rentalDays INTEGER NOT NULL,
        startDate TEXT NOT NULL,
        totalCost REAL NOT NULL,
        status TEXT NOT NULL,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  Future<int> createUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUserByUsername(String username) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> getUserByNik(String nik) async {
    final db = await database;
    final maps = await db.query('users', where: 'nik = ?', whereArgs: [nik]);

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<UserModel?> login(String usernameOrNik, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: '(username = ? OR nik = ?) AND password = ?',
      whereArgs: [usernameOrNik, usernameOrNik, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> createRental(RentalModel rental) async {
    final db = await database;
    return await db.insert('rentals', rental.toMap());
  }

  Future<List<RentalModel>> getRentalsByUserId(int userId) async {
    final db = await database;
    final maps = await db.query(
      'rentals',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'id DESC',
    );

    return maps.map((map) => RentalModel.fromMap(map)).toList();
  }

  Future<int> updateRental(RentalModel rental) async {
    final db = await database;
    return await db.update(
      'rentals',
      rental.toMap(),
      where: 'id = ?',
      whereArgs: [rental.id],
    );
  }

  Future<int> deleteRental(int id) async {
    final db = await database;
    return await db.delete('rentals', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
