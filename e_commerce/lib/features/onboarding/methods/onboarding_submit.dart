import 'package:flutter/material.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../login/presentation/ui/login_screen.dart';

void submit(BuildContext context){
  CacheHelper.setData('newUser', false).then((value){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=> LoginScreen()),
            (route) => false
    );
  });
}