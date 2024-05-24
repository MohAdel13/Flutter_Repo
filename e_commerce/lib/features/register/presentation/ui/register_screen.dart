import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../core/style/colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../login/presentation/ui/login_screen.dart';
import '../../bloc/register_cubit.dart';
import '../../bloc/register_states.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        builder: (BuildContext context, RegisterState state){
          if(state is RegisterLoadingState){
            EasyLoading.show();
          }
          else if(state is RegisterErrorState){
            EasyLoading.showError(state.error);
            //print(state.error);
          }
          else if(state is RegisterSuccessState){
            EasyLoading.showSuccess('Register success...');
          }
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          'REGISTER',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 50.0
                          ),
                        ),
                        const Text(
                          'Register now to get the newest offers',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 60.0,),
                        CustomTextFormField(
                          controller: nameController,
                          label: 'Name',
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Name...";
                            }
                            return null;
                          },
                          type: TextInputType.text,
                          prefix: const Icon(Icons.person, color: Colors.grey),
                        ),
                        const SizedBox(height: 15.0,),
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
                          controller: phoneController,
                          label: 'Phone',
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Phone number...";
                            }
                            return null;
                          },
                          type: TextInputType.phone,
                          prefix: const Icon(Icons.phone, color: Colors.grey),
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
                          obscure: cubit.passObscure,
                          prefix: const Icon(Icons.lock, color: Colors.grey),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.changePassVisibility();
                            },

                            icon: cubit.passObscure?
                            Icon(Icons.visibility, color: mainColor,):
                            const Icon(Icons.visibility_off, color: Colors.redAccent,),


                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        CustomTextFormField(
                          controller: confPasswordController,
                          label: 'Confirm Password',
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please Enter Your Password Again...";
                            }
                            else if(value != passwordController.text){
                              return "Password Doesn't Match...";
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          obscure: cubit.confPassObscure,
                          prefix: const Icon(Icons.lock, color: Colors.grey),
                          suffix: IconButton(
                            onPressed: (){
                              cubit.changeConfPassVisibility();
                            },

                            icon: cubit.confPassObscure?
                            Icon(Icons.visibility, color: mainColor,):
                            const Icon(Icons.visibility_off, color: Colors.redAccent,),


                          ),
                        ),
                        const SizedBox(height: 15.0,),
                        const SizedBox(height: 30.0,),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                cubit.register(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  confPassword: confPasswordController.text,
                                  phone: phoneController.text,
                                  context: context
                                );
                              }
                            },
                            color: mainColor,
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: const Text('REGISTER', style: TextStyle(color: Colors.white, fontSize: 20.0))
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already Have An Account ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                  (route) => false
                                );
                              },
                                child: const Text('Login')
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
        listener: (BuildContext context, RegisterState state) {},
      ),
    );
  }
}
