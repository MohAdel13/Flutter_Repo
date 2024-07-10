import 'package:chatty/core/style/colors.dart';
import 'package:chatty/features/login/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserItemWidget extends StatelessWidget {
  final UserModel user;
  UserItemWidget({required this.user});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20.0,
        ),

        CircleAvatar(
          radius: 30.0,
          backgroundImage: user.image != ''? NetworkImage(
            user.image!,
          ): null,
        ),

        const SizedBox(
          width: 20.0,
        ),

        Expanded(
          child: Text(
            user.name!,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),

        const SizedBox(
          width: 20.0,
        ),

        const Spacer(),

        IconButton(
          onPressed: (){},
          icon: FaIcon(FontAwesomeIcons.plus, color: mainColor,)
        ),

        const SizedBox(
          width: 20.0,
        ),
      ],
    );
  }
}
