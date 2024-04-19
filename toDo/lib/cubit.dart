import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/states.dart';
import 'package:todo/todo_screen.dart';

import 'archived_screen.dart';
import 'done_screen.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit(): super(AppInitState());
  late Database database;

  List<Map> todoData = [];
  List<Map> doneData = [];
  List<Map> archivedData = [];


  int currentIndex = 0;

  List<String> titles = [
    'Todo',
    'Archived',
    'Done'
  ];

  List<Widget> screens = [
    TodoScreen(),
    ArchivedScreen(),
    DoneScreen()
  ];
  void createDatabase() async{
    database = await openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version)async{
          print('Database is created...');
          await database.execute('CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, date TEXT,'
              'time TEXT, status TEXT)').
          then((value){
            print('Table is created...');
          });
        },
        onOpen: (database) async{
          await getAllTasks(database).catchError((error){
            print('Error happened while getting data from database: ${error.toString()}');
          }).then((value){
            emit(DatabaseCreateState());
            print('Database is opened...');
          });
        }
    );
  }

  insertIntoDatabase(
      { required String title,
        required String date,
        required String time,
        required BuildContext context}) async {
    await database.transaction((txn)async{
      await txn.rawInsert('INSERT INTO task(title, date, time, status) VALUES ("$title", "$date", "$time", "New")').then((value){
          print('$value is inserted...');
          emit(DatabaseInsertState());
          Navigator.pop(context, true);
      }).catchError((error){
        print('Error happened while inserting: ${error.toString()}');
      });
    });
  }

  Future<void> updateDatabase({required String status,required int id})async{
    await database.rawUpdate('UPDATE task SET status = "$status" WHERE id = $id').then((value){
      emit(DatabaseUpdateState());
    });
  }

  void afterDatabaseChange()async{
      await getAllTasks(database).then((value){
      emit(DatabaseGetState());
    }).catchError((error){
      print('Error happened while getting data from database: ${error.toString()}');
    });
  }

  Future<void> getAllTasks(Database database)async {
    await database.rawQuery('SELECT * FROM task WHERE status = "New"').then((value){
      todoData = value;
    });

    await database.rawQuery('SELECT * FROM task WHERE status = "Archived"').then((value){
      archivedData = value;
    });

    await database.rawQuery('SELECT * FROM task WHERE status = "Done"').then((value){
      doneData = value;
    });
  }

  static AppCubit getInstance(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int id){
    currentIndex = id;
    emit(ChangeIndexState());
  }

  Future<void> deleteFromDatabase(int id)async{
    await database.rawDelete('DELETE FROM task WHERE id = $id').then((value){
      emit(DatabaseDeleteState());
    });
  }
}