import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  //Singelton
  DBHelper._();

  static final DBHelper getinstance=DBHelper._();
  //table
  static final String TABLE_NOTE="note";
  static final String NOTE_COLUMN_SR_N="sr_no";
  static final String NOTE_COLUMN_TITLE="title";
  static final String NOTE_COLUMN_DESC="description";
  Database? myDB;
  Future<Database> getDB() async {
    myDB??=await openDB();
    return myDB!;
    // if(myDB==null) {
    //   return myDB!;
    // }
    // else{
    //   myDB= await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dbPath,onCreate:(db,version){
      //create all ur tables here
      db.execute("create table $TABLE_NOTE($NOTE_COLUMN_SR_N integer primary key autoincrement,$NOTE_COLUMN_TITLE text,$NOTE_COLUMN_DESC text)");
    } ,version: 1);
  }
  //all queries
  //insertion
  Future<bool> insertNote({required String mtitle,required String mdescription}) async {
    var db=await getDB();
    int rowsAffected=await db.insert(TABLE_NOTE, {
      NOTE_COLUMN_TITLE:mtitle,
      NOTE_COLUMN_DESC:mdescription
    });
    return rowsAffected>0;
  }

  //reading alldata
  Future<List<Map<String, Object?>>> readData() async {
    var db = await getDB();
    return await db.query(TABLE_NOTE);
  }

  // Fix update method
  Future<int> updateData(String updatedTitle, String updatedDesc, int srno) async {
    var db = await getDB();
    return await db.update(
      TABLE_NOTE,
      {
        NOTE_COLUMN_TITLE: updatedTitle,
        NOTE_COLUMN_DESC: updatedDesc,
      },
      where: "$NOTE_COLUMN_SR_N = ?",
      whereArgs: [srno],
    );
  }

// Fix delete method
  Future<int> deleteData(int srno) async {
    var db = await getDB();
    return await db.delete(
      TABLE_NOTE,
      where: "$NOTE_COLUMN_SR_N = ?",
      whereArgs: [srno],
    );
  }
}