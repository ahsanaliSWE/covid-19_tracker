import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'covid_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE covid_data(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cases REAL,
        active REAL,
        recovered REAL,
        deaths REAL,
        critical REAL,
        tests REAL,
        todayCases REAL,
        todayDeaths REAL,
        todayRecovered REAL,
        affectedCountries REAL
      )
    ''');
    
  }

  Future<void> insertCovidData(Map<String, double> dataMap) async {
    final Database db = await database;
    await db.insert('covid_data', dataMap);
  }

  Future<Map<String, double>> getCovidData() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('covid_data', limit: 1);

    if (maps.isNotEmpty) {
      return {
        "cases": maps[0]['cases'],
        "active": maps[0]['active'],
        "recovered": maps[0]['recovered'],
        "deaths": maps[0]['deaths'],
        "critical": maps[0]['critical'],
        "tests": maps[0]['tests'],
        "todayCases": maps[0]['todayCases'],
        "todayDeaths": maps[0]['todayDeaths'],
        "todayRecovered": maps[0]['todayRecovered'],
        "affectedCountries": maps[0]['affectedCountries'],
      };
    } else {
      throw Exception('No data available');
    }
  }

}
