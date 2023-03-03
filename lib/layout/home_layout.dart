import 'package:intl/intl.dart';
import '../components/barell_file.dart';
////////////////////////////////////convert stateful into stateless for using bloc
//todo:56
class HomeLayout extends StatelessWidget {
//todo:16 call create Database //delete after bloc
  // @override//   void initState() {createDatabase();super.initState();}
  @override 
  Widget build(BuildContext context) {
    //todo:59 //.. acces what's inside appCubit (seems like you saved in a variable)
    return BlocProvider(create: (BuildContext context )=> AppCubit()..createDatabase(),//todo:71 
   
      child: BlocConsumer<AppCubit, AppStates>(
         listener: (BuildContext context , AppStates state){
           //todo:81
           if(state is AppInsertDatabaseState){
             Navigator.pop(context);
           }
         },
         //builder returns the design of the app
         builder: (BuildContext context , AppStates state){
           //todo:63 //used here inside builder so that i can use context
          AppCubit cubit = AppCubit.get(context);
           return Scaffold(
          key:scaffoldKey,//todo:22
          //todo:64
          appBar: AppBar(title: Text(cubit.screenNames[cubit.currentIndex]),),//todo:11
           //todo:65
          body:cubit.screens[cubit.currentIndex],//todo:9
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              //todo:25
              if(cubit.isBottomSheetShown){//todo:75
                //todo:34 مش فاهم بتعمل اي الصراحة
                if(formKey.currentState!.validate()){
                  //todo:80
                  cubit.insertToDatabase(
                    title: titleController.text, date: dateController.text, time: timeController.text);      
                } 
              }else{
              //todo:23
              scaffoldKey.currentState!.showBottomSheet(
                (context) => Container(padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  //todo:33
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //todo:30
                        CustomFormField(
                          title: 'task title', controller: titleController,icon: Icon(Icons.title),
                        returnedtext: 'title is empty', onTap: (){},),
                        SizedBox(height: 10,),
                        CustomFormField(
                          title: 'task Time', controller: timeController,type: TextInputType.datetime,
                        returnedtext: 'time cannot be empty',icon : Icon(Icons.watch),
                         onTap: (){
                            //todo:31
                           showTimePicker(
                             context: context,
                              initialTime:TimeOfDay.now()).then((value) {
                                timeController.text = value!.format(context);
                              } );
                         },),
                         SizedBox(height:10),
                         //todo:35
                         CustomFormField(
                          title: 'task date', controller: dateController,type: TextInputType.datetime,
                        returnedtext: 'date cannot be empty',icon : Icon(Icons.calendar_today),
                         onTap: (){
                           showDatePicker(context: context,
                            initialDate: DateTime.now(), firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2021-09-30')).then((value) {
                              //todo:36
                            dateController.text = DateFormat.yMMMd().format(value!);
                            });
                            },),
                         ],
                    ),),
                ),elevation:20.0
                //todo:42
                ).closed.then((value) {
                 cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);//todo:78
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add); //todo:78
            }
            },
            child: Icon(cubit.fabIcon),//todo:75
          ),
          //todo:1
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //todo:66
            currentIndex: cubit.currentIndex,
            onTap: (index){
              //todo:67
              cubit.changeIndex(index);},
            items: [
              BottomNavigationBarItem( icon: Icon(Icons.menu),label: 'Task',),
              BottomNavigationBarItem(icon: Icon(Icons.check),label: 'done'),
              BottomNavigationBarItem(icon: Icon(Icons.archive_outlined),label: 'archived'),
            ],
          ),
       );
      
         },),
    );} 
}
     