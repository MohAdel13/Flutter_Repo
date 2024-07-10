import 'package:chatty/features/add%20post/presentation/ui/add_post_screen.dart';
import 'package:chatty/features/home%20layout/bloc/home_layout_states.dart';
import 'package:chatty/features/settings/presentation/ui/settings_screen.dart';
import 'package:chatty/features/users/presentation/ui/users_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../news feed/presentation/ui/news_feed_screen.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates>{
  HomeLayoutCubit(): super(HomeLayoutInitState());

  int currentIndex = 0;

  List<String> titles = [
    'News Feed',
    'Chats',
    'Create Post',
    'Users',
    'Settings'
  ];

  List<Widget> screens = [
    NewsFeedScreen(),
    NewsFeedScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  static HomeLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  void changeIndex(int index){
    currentIndex = index;
    emit(HomeLayoutIndexChange());
  }
}