import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_tutorial/utils/SqlHelper.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String,dynamic>> itemList=[];
  bool _mounted=false;
  bool _isLoading = false;
  late Database db;
  
  //===================initialize the database
  getDbInstance()async{
      db =  await SqlHelper.initDb();
      print(db);
  }
  
  
  showTables()async{
    final result = await SqlHelper.showTables(db);
    print(result);
    
  }
  
  createTable()async{
    final result = await SqlHelper.createTable(db);
    print(result.toString());
  }

  deleteTable()async{
    final result = await SqlHelper.deleteTable('items', db);
    print(result.toString());
  }

  void getDataList()async{
    _mounted = true;
    if(_mounted){
      _isLoading = true;
    }
    final data = await SqlHelper.getData(db);
    print(data);
    if(_mounted){
      setState(() {
        _isLoading = false;
        itemList = data;
      });
    }
  }

  void createData()async{
    final res = await SqlHelper.createItem('kirana', 'kiranan saman lana hai',db);
    print(res);
  }
  
  @override
  void initState() {
    getDbInstance();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqlite tutorials'),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
                itemList.toString()
            ),
          ),
          TextButton(
              onPressed: (){
                createTable();
              },
              child: Text('create table')
          ),
          TextButton(
              onPressed: (){
                showTables();
        }, 
              child: Text('show tables')
          ),
          TextButton(
              onPressed: (){
                createData();
              },
              child: Text('create data')
          ),
          TextButton(
              onPressed: (){
                getDataList();
              },
              child: Text('get data list')
          ),
          TextButton(
              onPressed: (){
                deleteTable();
              },
              child: Text('delete the table')
          )
        ],
      )
    );
  }
}
