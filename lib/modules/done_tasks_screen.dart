//todo:3
import '../components/barell_file.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var tasks = AppCubit.get(context).doneTasks;
    //todo:89
    // we don't need scaffold here as we have scaffold in todo4 as it body into scaffold
    return tasks.length == 0?taskBuilder()
    :BlocConsumer<AppCubit,AppStates>(
      listener: (context , state) {},
      builder: (context , state){
        return ListView.separated(
        itemBuilder: (context , index) => buildTaskItem(tasks[index],context),
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