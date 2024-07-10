import 'package:chatty/core/style/colors.dart';
import 'package:chatty/core/widgets/custom_material_button.dart';
import 'package:chatty/core/widgets/custom_text_button.dart';
import 'package:chatty/features/add%20post/bloc/add_post_cubit.dart';
import 'package:chatty/features/add%20post/bloc/add_post_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AddPostCubit()..getUser(),
      child: BlocConsumer<AddPostCubit, AddPostStates>(
        builder: (BuildContext context, AddPostStates state) {  
          AddPostCubit cubit = AddPostCubit.get(context);
          if(state is AddPostLoadingState){
            EasyLoading.show();
            return Container(color: Colors.white,);
          }
          else if(state is AddPostErrorState){
            EasyLoading.showError('Connection Failed..');
            return Container(color: Colors.white,);
          }
          else{
            EasyLoading.dismiss();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state is AddPostCreatedLoadingState?
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: LinearProgressIndicator(
                      color: mainColor,
                    ),
                  ): const SizedBox.shrink(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          cubit.user.image!,
                        ),
                        radius: 30.0,
                      ),
                      const SizedBox(width: 20.0,),
                      Text(cubit.user.name!, style: Theme.of(context).textTheme.headlineLarge,)
                    ],
                  ),
                  const SizedBox(width: 15.0,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: textController,
                        maxLines: 50,
                        decoration: InputDecoration(
                            hintText: 'What\'s in your mind?',
                            hintStyle: Theme.of(context).textTheme.titleSmall,
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  cubit.image != null? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          height: 150,
                          child: Image.file(cubit.image!),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: (){
                              cubit.deletePhoto();
                            },
                            icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.white,),
                          ),
                        )
                      ]
                  ): const SizedBox.shrink(),
                  Align(
                      alignment: Alignment.center,
                      child: CustomTextButton(
                          onPressed: (){
                            cubit.addPhoto();
                          },
                          text: '+ Add photo')
                  ),
                  CustomMaterialButton(
                      onPressed: (){
                        cubit.createPost(text: textController.text);
                      },
                      text: 'Post'
                  )
                ],
              ),
            ),
          );
        }, 
        listener: (BuildContext context, AddPostStates state) {
          if(state is AddPostCreatedSuccessState){
            Navigator.pop(context);
          }
        },
        
      ),
    );
  }
}
