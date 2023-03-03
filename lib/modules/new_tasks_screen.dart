//todo:7
import '../components/barell_file.dart';

class NewTasksScreen extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {

    var tasks = AppCubit.get(context).newTasks;
    
    // we don't need scaffold here as we have scaffold in todo4 as it body into scaffold
    //todo:48
    return tasks.length == 0 ? 
    taskBuilder() : 
    BlocConsumer<AppCubit,AppStates>(//todo:82
      listener: (context , state) {},
      builder: (context , state){
        //todo:83
        
        return ListView.separated(
        itemBuilder: (context , index) => buildTaskItem(tasks[index],context),//todo:54
        separatorBuilder: (context , index) => Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemCount:tasks.length,
      );
      },
    );
  }
}
