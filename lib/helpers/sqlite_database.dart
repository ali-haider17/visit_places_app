import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart' as p;

class SqlDatabase{

  //Todo: Defining a number of static methods which are available without the need
  //todo: of instantiating te class

  //Todo: Database method which takes the Database type and initializes thhe database
  static Future<Database> database() async {
    //Todo: Using getDatabasesPath(), to get the correct Path to store the database to
    final databasePath = await sql.getDatabasesPath();

    //Todo: Using join method to create a new path with a filename
    final myPath = p.join(databasePath, "database.db");

    //Todo: Using openDatabase() method which allows to open the database and either
    //todo: opens the existing database or creates a new one
    //todo: It takes an onCreate argument that take a function to be executed when
    //todo: SQFLite tries to open the database
     return sql.openDatabase(
        myPath,

        //Todo: specifying the database object(db) and version to open the file with it
        //todo: and can override the existing database by changing the version.
        //todo: By getting access to the database when first created and can return
        //todo: db.execute() to run sql queries against the database
        onCreate: (db, version){
          return db.execute(
            //TODO: STORING LOCATION IN SQLITE
            //Todo: 2.10 Modifying the table to store location as well
              "CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)"
          );
        },
        version: 1
    );
  }


  //Todo: Method to insert data into a table
  static Future<void> insert(String table, Map<String, Object> data) async {

    //Todo: Fetching the database first
    final database = await SqlDatabase.database();

    //Todo: Using the insert method
    //todo: Inserting the data into te opened database
    //todo: It also takes a conflictAlgorithm argument that takes the property here
    //todo: sql.ConflictAlgorithm.replace which will override the existing entry with
    //todo: new data when already there exists an ID in the table inserting the data for.
     database.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }


  //Todo: Method to get data from a table
  static Future <List<Map<String, dynamic>>> getData(String table) async {

    //Todo: Fetching the database first
    final database = await SqlDatabase.database();

    //Todo: Using the query method
    //todo: takes the table to fetch the data from and returns all the data in
    //todo: table
    //todo: query returns a future that returns a list of maps that was inserted
    return database.query(table);
  }
}