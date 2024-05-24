import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/bloc_observer.dart';
import 'package:e_commerce/core/network/local/cache_helper.dart';
import 'package:e_commerce/core/network/remote/dio_helper.dart';
import 'package:e_commerce/core/style/themes.dart';
import 'package:e_commerce/features/login/presentation/ui/login_screen.dart';
import 'package:e_commerce/features/onboarding/presentation/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/shop_layout/presentation/ui/shop_layout_screen.dart';

void main()async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: !CacheHelper.sharedPreferences.containsKey('newUser') ? OnboardingScreen():
          !CacheHelper.sharedPreferences.containsKey('token')? LoginScreen(): ShopLayoutScreen(),
      //home: HomeScreen(),
      theme: lightTheme,
      darkTheme: lightTheme,
      builder: EasyLoading.init(),
    );
  }
}
