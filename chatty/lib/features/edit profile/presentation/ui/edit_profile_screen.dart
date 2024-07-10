import 'package:chatty/core/style/colors.dart';
import 'package:chatty/core/widgets/custom_text_button.dart';
import 'package:chatty/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../settings/bloc/settings_cubit.dart';
import '../../../settings/bloc/settings_states.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      builder: (BuildContext context, SettingsStates state) {
        SettingsCubit cubit = SettingsCubit.get(context);
        nameController.text = cubit.user.name!;
        phoneController.text = cubit.user.phone!;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Profile'),
              actions: [
                CustomTextButton(
                  onPressed: () {
                    cubit.updateUser(phone: phoneController.text, name: nameController.text);
                  },
                  text: 'Update',
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    state is SettingsUserUpdateLoadingState
                      ? Column(
                          children: [
                            LinearProgressIndicator(
                              color: mainColor,
                            ),
                            const SizedBox(
                              height: 20.0,
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                    Container(
                      height: 220.0,
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: cubit.coverImage == null
                                    ? Image(
                                        image:
                                            NetworkImage(cubit.user.coverImage!),
                                        fit: BoxFit.cover)
                                    : Image.file(
                                        cubit.coverImage!,
                                        fit: BoxFit.cover,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15.0),
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.changeCoverImage();
                                    },
                                    icon: CircleAvatar(
                                      backgroundColor: mainColor,
                                      child: const FaIcon(
                                        FontAwesomeIcons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage:
                                          cubit.profileImage == null
                                              ? NetworkImage(cubit.user.image!)
                                              : FileImage(cubit.profileImage!),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.changeProfileImage();
                                        },
                                        icon: Container(
                                          child: CircleAvatar(
                                            backgroundColor: mainColor,
                                            child: const FaIcon(
                                              FontAwesomeIcons.camera,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        controller: nameController,
                        label: 'Name',
                        prefix: const Icon(Icons.person),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You Must Enter Your name!";
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomTextFormField(
                        controller: phoneController,
                        label: 'Phone',
                        prefix: const Icon(Icons.phone),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "You Must Enter Your Phone!";
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
            ));
      },
      listener: (BuildContext context, SettingsStates state) {
        if (state is SettingsUserUpdateSuccessState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
