import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static const _databaseName = 'Policied.db';
  static const _databaseVersion = 1;
  static const _childPolicyTable = 'ChildPolicy';
  static const _childPolicyId = 'childPolicyId';
  static const _masterPolicyId = 'masterPolicyId';
  static late BriteDatabase _streamDatabase;
  DatabaseHelper._();
  static final instance = DatabaseHelper._();
  static var lock = Lock();
  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_childPolicyTable (
        $_childPolicyId INTEGER PRIMARY KEY,
        masterPolicyId TEXT,
        premiumPaid REAL, 
        sumInsured REAL,
        activeSinceDate TEXT,
        expirationDate TEXT
      )
    ''');
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(
      documentsDirectory.path,
      _databaseName,
    );
    // TODO: Remember to turn off debugging before deploying app to store(s).
    Sqflite.setDebugModeOn(true);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    await lock.synchronized(() async {
      if (_database == null) {
        _database = await _initDatabase();
        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  void close() {
    _streamDatabase.close();
  }

  List<ChildPolicyModel> parseChildPolicies(
    List<Map<String, dynamic>> childPolicyList,
  ) {
    final childPolicies = <ChildPolicyModel>[];
    for (final childPolicyMap in childPolicyList) {
      final childPolicy = ChildPolicyModel.fromJson(childPolicyMap);
      childPolicies.add(childPolicy);
    }
    return childPolicies;
  }

  Future<List<ChildPolicyModel>> findAllChildPoliciesByMasterPolicyId(
      String masterPolicyId) async {
    final db = await DatabaseHelper.instance.streamDatabase;
    final childPolicyList = await db.query(
      DatabaseHelper._childPolicyTable,
      where: 'masterPolicyId = $masterPolicyId',
    );
    final childPolicies = parseChildPolicies(childPolicyList);
    return childPolicies;
  }

  Stream<List<ChildPolicyModel>> watchAllChildPoliciesByMasterPolicyId(
      String masterPolicyId) async* {
    final db = await DatabaseHelper.instance.streamDatabase;
    final childPolicies = db.createQuery(
      DatabaseHelper._childPolicyTable,
      where: '$_masterPolicyId = ?',
      whereArgs: [masterPolicyId],
    ).mapToList((row) => ChildPolicyModel.fromJson(row));

    yield* childPolicies;
  }

  Stream<List<ChildPolicyModel>>
      watchAllChildPoliciesByMasterPolicyIdAndPremiumPaidRange(
    String masterPolicyId, [
    double minPremium = 0,
    double maxPremium = 9999999,
  ]) async* {
    final db = await DatabaseHelper.instance.streamDatabase;
    final childPolicies = db.createQuery(
      DatabaseHelper._childPolicyTable,
      where: '$_masterPolicyId = ? '
          'AND premiumPaid >= ? '
          'AND premiumPaid <= ?',
      whereArgs: [masterPolicyId, minPremium, maxPremium],
    ).mapToList((row) => ChildPolicyModel.fromJson(row));
    yield* childPolicies.asBroadcastStream();
  }

  Future<ChildPolicyModel> findChilPolicyById(int id) async {
    final db = await DatabaseHelper.instance.streamDatabase;
    final childPolicyList = await db.query(
      DatabaseHelper._childPolicyTable,
      where: 'id = $id',
    );
    final childPolicies = parseChildPolicies(childPolicyList);
    return childPolicies.first;
  }

  Future<int> _insert(String table, Map<String, dynamic> row) async {
    final db = await DatabaseHelper.instance.streamDatabase;
    return db.insert(table, row);
  }

  Future<int> insertChildPolicy(ChildPolicyModel childPolicy) {
    return _insert(
      DatabaseHelper._childPolicyTable,
      childPolicy.toJson(),
    );
  }

  Future<int> _delete(String table, String columnId, int id) async {
    final db = await DatabaseHelper.instance.streamDatabase;
    return db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteChildPolicy(int id) {
    return _delete(
      DatabaseHelper._childPolicyTable,
      DatabaseHelper._childPolicyId,
      id,
    );
  }

  Future<int> _update(
    String table,
    Map<String, dynamic> row,
    String columnId,
    int id,
  ) async {
    final db = await DatabaseHelper.instance.streamDatabase;
    return db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateChildPolicy(ChildPolicyModel childPolicy) async {
    return _update(
      DatabaseHelper._childPolicyTable,
      childPolicy.toJson(),
      DatabaseHelper._childPolicyId,
      childPolicy.childPolicyId!,
    );
  }
}
