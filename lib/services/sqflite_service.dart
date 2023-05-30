import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfLiteService {
  Database? db;
  int versionCode = 1;
  String tableName = "shopping_card";

  String columnId = "_id";
  String columnProductId = "product_id";

  SqfLiteService();

  Future<Database> getDb() async {
    if (db == null) {
      db = await createDatabase();
      return db!;
    }
    return db!;
  }

  Future<Database> createDatabase() async {
    String directoryPath = await getDatabasesPath();
    String databasePath = join(directoryPath, 'list.db');
    var db = await openDatabase(databasePath, version: versionCode, onCreate: populateDb);
    return db;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnProductId INTEGER)");
  }

  Future<bool> addItem(int productId) async {
    Database db = await getDb();
    var isNotExists = !await checkValueExists(productId);
    if (isNotExists) {
      var id = await db.insert(tableName, {columnProductId: productId});
      print("Item id: $id");
    }
    return isNotExists;
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await getDb();
    var result = await db.query(tableName, columns: [columnId, columnProductId]);
    return result;
  }

  Future<void> deleteProduct(int id) async {
    Database db = await getDb();
    await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<bool> checkValueExists(int productId) async {
    Database db = await getDb();
    final queryResult = await db.query(
      tableName,
      where: '$columnProductId = ?',
      whereArgs: [productId],
      limit: 1,
    );
    return queryResult.isNotEmpty;
  }
}
