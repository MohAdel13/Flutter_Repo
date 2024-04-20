import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/features/main%20layout/bloc/main_states.dart';
import 'package:todo/features/todo/presentations/ui/todo_screen.dart';
import '../../../core/constants/constants.dart';
import '../../archived/presentations/ui/archived_screen.dart';
import '../../done/presentations/ui/done_screen.dart';

class MainCubit extends Cubit<MainState>{
  MainCubit(): super(MainInitState());

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

  insertIntoDatabase({
    required String title,
    required String date,
    required String time,
    // required BuildContext context
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO task(title, date, time, status) VALUES ("$title", "$date", "$time", "New")')
          .then((value) {
        print('$value is inserted...');
        emit(DatabaseInsertState());
      }).catchError((error) {
        print('Error happened while inserting: ${error.toString()}');
      });
    });
  }

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
        }
    ).then((value){
      emit(DatabaseCreateState());
      return value;
    });
  }

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int id){
    currentIndex = id;
    emit(ChangeIndexState());
  }

}