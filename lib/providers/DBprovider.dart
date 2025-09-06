import 'package:flutter/material.dart';
import 'package:notes/helpers/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class DBprovider extends ChangeNotifier{
  List<Map<String,dynamic>> _mdata=[];

  //events
  Future<void> addNote(String title,String desc) async {
    bool check=await DBHelper.getinstance.insertNote(mtitle: title, mdescription: desc);
    if(check){
      _mdata=await DBHelper.getinstance.readData();
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> getNotes()=>_mdata;

  Future<void> updateNote(int srNo,String title,String desc) async {
    int check=await DBHelper.getinstance.updateData(title, desc, srNo);
    if(check>0){
      _mdata=await DBHelper.getinstance.readData();
      notifyListeners();
    }
  }
  Future<void> getInitialNotes() async {
    _mdata=await DBHelper.getinstance.readData();
    notifyListeners();
  }

  Future<void> deleteNote(int srNo) async {
    int check=await DBHelper.getinstance.deleteData(srNo);
    if(check>0){
      _mdata=await DBHelper.getinstance.readData();
      notifyListeners();
    }
  }
}