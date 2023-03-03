//todo:58
import '../../components/barell_file.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  
  static AppCubit get(context) => BlocProvider.of(context);

  //todo:60 moved from homeLayout or constants

  //todo:8
  List<Widget> screens = [NewTasksScreen(),DoneTasksScreen(),ArchivedTasksScreen()];
  //todo:10
  List<String> screenNames = ['newTask', 'doneTask', 'archivedTasks'];
  int currentIndex = 0;

  //todo:62
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  //todo:18 make it global
  Database? database;
  //todo:72 (was 49 in constants)
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  //todo:70 moved from homeLayout or methods

  /////////////////////////////////////
  //todo:13 create Database
  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database Created');
      //todo:14 create table
      database
          .execute('''CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT ,
           date TEXT,time TEXT,status TEXT)''').then((value) {
        print('table created');
      }).catchError((error) {
        print('error occured while creating' + error.toString());
      });
    },
        //todo:15 open Database
        onOpen: (database) {
      //todo:44
      getDataFromDatabase(database);
      print('Database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  /////////////////////////////////////
  //todo:17
  //طالما محطيناش <> تبقي dynamic
  insertToDatabase(
      //todo:39
      {required String title,
      required String date,
      required String time}) async {
    //todo:19
    return await database!.transaction((txn) async {
      txn.rawInsert(
        //todo:40
        'INSERT INTO TASKS(title , date,time, status) VALUES("$title", "$date", "$time", "new")',
      ).then((value) {
        print('$value inserted successfully');
        //todo:73
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((onError) {
        print('error when inserting new Record' + onError.toString());
      });
      // return null;
    });
  }

  ///////////////////////////////////////
  ///get Database
  //todo:43
  //todo:87 convert from future to void and add .then
  void getDataFromDatabase(database) {
    //todo:90
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM TASKS').then((value) {
      //todo:88
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else if (element['status'] == 'archive') archivedTasks.add(element);
      });

      emit(AppGetDatabaseState());
    });
  }

  //todo:84
  void updateData({required String status, required int id}) async {
    database!.rawUpdate('UPDATE TASKS SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  //todo:90/////////////////////////
  void deleteData({required int id}) async {
    database!.rawDelete('DELETE FROM TASKS WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  //todo:74
  //todo:24 hide or show bottom sheet
  bool isBottomSheetShown = false;
  //todo:26
  IconData fabIcon = Icons.edit;

  //todo:76 change the shape of fab and bottomsheet
  void changeBottomSheetState(
      {required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}