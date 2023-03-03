import 'components/barell_file.dart';
void main() {
  //todo:69
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //todo:2
      home: HomeLayout(),
    );
  }
}