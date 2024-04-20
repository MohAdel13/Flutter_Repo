import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/widgets/custom_text_form_field_widget.dart';
import 'package:todo/features/main%20layout/bloc/main_cubit.dart';
import 'package:todo/core/functions/methods_for_date_and_time.dart';
import 'package:todo/features/main%20layout/bloc/main_states.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return BlocConsumer<MainCubit, MainState>(
      builder: (BuildContext context, MainState state) {
        MainCubit cubit = MainCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "New Task",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomTextFormFieldWidget(
                          labelText: 'Title',
                          prefixIcon: const Icon(
                            Icons.title,
                            color: Colors.grey,
                          ),
                          controller: titleController,
                          type: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Title cannot be empty..";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormFieldWidget(
                          labelText: 'Date',
                          prefixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          ),
                          readOnly: true,
                          controller: dateController,
                          onTap: () {
                            dateOnTap(context).then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!).toString();
                            });
                          },
                          type: TextInputType.datetime,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Date cannot be empty..";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomTextFormFieldWidget(
                          controller: timeController,
                          labelText: 'Time',
                          prefixIcon: const Icon(
                            Icons.watch_later,
                            color: Colors.grey,
                          ),
                          readOnly: true,
                          onTap: () {
                            timeOnTap(context).then((value) {
                              timeController.text = value!.format(context);
                            });
                          },
                          type: TextInputType.datetime,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Time cannot be empty..";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.blue,
                        ),
                        child: MaterialButton(
                          padding: const EdgeInsets.all(12.0),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.insertIntoDatabase(
                                title: titleController.text,
                                date: dateController.text,
                                time: timeController.text,
                                // context: context
                              );
                            }
                          },
                          child: const Text('Save',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, MainState state) {
        if (state is DatabaseInsertState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
