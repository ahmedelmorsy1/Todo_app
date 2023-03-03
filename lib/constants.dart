import 'components/barell_file.dart';
//todo:5
var texStyle = TextStyle(fontSize: 25,color: Colors.black);

  //todo:21 key
  var scaffoldKey = GlobalKey<ScaffoldState>();
  //todo:32 key
  var formKey = GlobalKey<FormState>();
 
  //todo:29
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


//todo:50 add map here 
//todo:91 dissmisible
Widget buildTaskItem(Map model ,BuildContext context) =>Dismissible(
      key:Key(model['id'].toString()),
      child: Padding(
         padding: const EdgeInsets.all(15.0),
        child: Row(
          //todo:47
          children: [
            CircleAvatar(radius: 40.0,
            child: Text('${model['time']}'),),//todo:51
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text('${model['title']}',//todo:52
                style: texStyle,),
                 Text('${model['date']}',//todo:53
                style: texStyle.copyWith(color: Colors.grey,fontSize: 20),),
              ],),
            ),
            //todo:86
             SizedBox(width: 20,),
             IconButton(icon: Icon(Icons.check_box),color: Colors.green, onPressed:(){
               //add context in method parameter above to have a context for the get
               AppCubit.get(context).updateData(status: 'done', id: model['id']);
             }),
             IconButton(icon: Icon(Icons.archive),color: Colors.grey, onPressed:(){
                AppCubit.get(context).updateData(status: 'archive', id: model['id']);
             })
          ],
        ),
      ),
    onDismissed: (direction){
      //todo:93
      AppCubit.get(context).deleteData(id: model['id']);
    },
    );

    //todo:93
    Widget taskBuilder()=> Center(child: Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
      Icon(Icons.menu,size: 100,color: Colors.black),
      Text('No tasks yet, please add some tasks')
    ],)
    );