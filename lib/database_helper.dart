import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transaksi_apps/model/barang_model.dart';
import 'package:transaksi_apps/model/transaksi_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    Database db = await database;
    return await db.query('transactions');
  }

  Future<List<Map<String, dynamic>>> getBarang() async {
    Database db = await database;
    return await db.query('barang');
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'transaksi_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nomor TEXT,
          date TEXT,
          kode TEXT,
          nama TEXT,
          nomor_telepon TEXT,
          nama_barang TEXT,
          harga_barang REAL,
          jumlah_barang INTEGER,
          total REAL
        )
      ''');

        await db.execute('''
        CREATE TABLE barang(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          kode_barang TEXT,
          nomor_barang TEXT,
          nama_barang TEXT,
          harga_barang REAL,
          jumlah_barang INTEGER,
          total REAL
        )
      ''');
      },
    );
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    Database db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<int> insertBarang(BarangModel barang) async {
    Database db = await database;
    return await db.insert('barang', barang.toMap());
  }

  Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteBarang(int id) async {
    final db = await database;
    await db.delete('barang', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> getStokByBarang(String barang) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('barang',
        columns: ['jumlah_barang'],
        where: 'nama_barang = ?',
        whereArgs: [barang]);

    if (result.isNotEmpty) {
      return result[0]['jumlah_barang'] as int;
    } else {
      return 0;
    }
  }

  Future<Map<String, dynamic>> getTransactionById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('transactions', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<TransactionModel> updateTransaction(
      int id, TransactionModel transaction) async {
    Database db = await database;

    Map<String, dynamic> transactionMap = transaction.toMap();
    transactionMap.remove('id');

    await db.update(
      'transactions',
      transactionMap,
      where: 'id = ?',
      whereArgs: [id],
    );

    return transaction;
  }

  Future<BarangModel> getBarangById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'barang',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return BarangModel.fromMap(result.first);
    } else {
      throw Exception('Barang not found');
    }
  }

  Future<BarangModel> updateBarang(int id, BarangModel barang) async {
    Database db = await database;

    Map<String, dynamic> barangMap = barang.toMap();
    barangMap.remove('id');

    await db.update(
      'barang',
      barangMap,
      where: 'id = ?',
      whereArgs: [id],
    );

    return barang;
  }

  Future<List<Map<String, dynamic>>> searchTransactions(
      String searchTerm) async {
    Database db = await database;
    return await db.query(
      'transactions',
      where: 'nama LIKE ?',
      whereArgs: ['%$searchTerm%'],
    );
  }

  Future<List<Map<String, dynamic>>> searchBarang(String searchTerm) async {
    Database db = await database;
    return await db.query(
      'barang',
      where: 'nama_barang LIKE ?',
      whereArgs: ['%$searchTerm%'],
    );
  }
}
