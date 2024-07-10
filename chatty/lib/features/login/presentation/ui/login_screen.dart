import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/style/colors.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../register/presentation/ui/register_screen.dart';
import '../../bloc/login_cubit.dart';
import '../../bloc/login_states.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (BuildContext context, LoginStates state){
          if(state is LoginLoadingState){
            EasyLoading.show();
          }
          else if(state is LoginErrorState){
            EasyLoading.showError(state.error!);
          }
          else if(state is LoginSuccessState){
            EasyLoading.showSuccess('Login success...');
          }
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            //resizeToAvoidBottomInset: false,
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50.0
                          ),
                        ),
                        const Text(
                          'Login now to chat with friends',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 60.0,),
                        CustomTextFormField(
                          controller: emailController,
                          label: 'Email',
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Email...";
                            }
                            return null;
                          },
                          type: TextInputType.emailAddress,
                          prefix: const Icon(Icons.email, color: Colors.grey),
                        ),
                        const SizedBox(height: 15.0,),
                        CustomTextFormField(
                          controller: passwordController,
                          label: 'Password',
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Password...";
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          obscure: cubit.obscure,
                          prefix: const Icon(Icons.lock, color: Colors.grey),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.changePassVisibility();
                            },

                            icon: cubit.obscure?
                            Icon(Icons.visibility, color: mainColor,):
                            const Icon(Icons.visibility_off, color: Colors.redAccent,),


                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        CustomMaterialButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubit.login(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context
                              );
                            }
                          },
                          text: 'LOGIN'
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'You Don\'t Have An Account ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            CustomTextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterScreen())
                                  );
                                },
                                text: 'Register Now'
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, LoginStates state) {},
      ),
    );
  }
}
