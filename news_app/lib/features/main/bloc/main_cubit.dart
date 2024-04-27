import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/local/shared_preferences_helper.dart';
import 'package:news_app/features/science/presentations/ui/science_screen.dart';
import 'package:news_app/features/sport/presentations/ui/sport_screen.dart';

import '../../business/presentations/ui/business_screen.dart';
import 'main_states.dart';

class MainCubit extends Cubit<MainState>{
  MainCubit(): super(MainInitState());

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  int currentIndex = 0;

  ThemeMode theme = ThemeMode.light;

  bool? isDark;

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex = index;
    emit(MainNavState());
  }

  Future<void> getThemeMode()async {
    emit(MainLoadingState());
    isDark = SharedPreferencesHelper.getIsDark();
    if(isDark == null){
      theme = ThemeMode.light;
      isDark = false;
      SharedPreferencesHelper.setIsDark(false).then((value){
        emit(MainThemeState());
      });
    }
    else{
      isDark = !isDark!;
      changeThemeMode();
    }
  }

  void changeThemeMode(){

    if (isDark! == true) {
      theme = ThemeMode.light;
      isDark = false;
    }

    else {
      theme = ThemeMode.dark;
      isDark = true;
    }
    SharedPreferencesHelper.setIsDark(isDark!).then((value){
      emit(MainThemeState());
    });
  }
}