import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/main%20layout/presentation/ui/home_layout.dart';

import 'core/bloc_observable.dart';

void main(){
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout()
    );
  }

}