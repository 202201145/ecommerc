import 'package:app1/data/api_manager.dart';
import 'package:app1/ui/auth/register/cubit/registerState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<Registerstates> {
  RegisterCubit() : super(RegisterInitialgState());
  final regformKey = GlobalKey<FormState>();
  final NameController =
      TextEditingController(text: "AbdAllah Elsayed");
  final MobileController = TextEditingController(text: "01206344840");
  final EmailController =
      TextEditingController(text: "202201145@gmail.com");
  final PasswordController = TextEditingController(text: "Elbod@123@123");
  final rePasswordController = TextEditingController(text: "Elbod@123@123");
  bool secure = true;

  void register() async {
    if (regformKey.currentState?.validate() == true) {
      try {
        emit(RegisterLoadingState());
        var response = await ApiManager.register(
            NameController.text,
            EmailController.text,
            PasswordController.text,
            rePasswordController.text,
            MobileController.text);
        print(response);
        if (response.statusMsg == 'fail') {
          emit(RegisterErrorState(errorMessage: response.message!));
          print(response.message);
          print('fail');
        } else {
          emit(RegisterSuccessState(response: response));
          print('error2');
        }
      } catch (e) {
        emit(RegisterErrorState(errorMessage: e.toString()));
        print('cat');
      }
    }
  }
}
