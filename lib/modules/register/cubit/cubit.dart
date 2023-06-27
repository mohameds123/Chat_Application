import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(InitialRegisterState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  void socialUserRegister(
  ) {
  emit(LoadingRegisterState());
  print('sss=>>>{${emailAddressController.text}');
  print('ppp=>>>{${passwordController.text}');
  FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: emailAddressController.text,
     password: passwordController.text,
  ).then((value){
    print(value.user!.uid);
    print(value.user!.email);
    value.user!.sendEmailVerification();
    setUserData(
        uId: value.user!.uid,
    );
    emit(RegisterSuccessState());
  }).catchError((error){
    print('User Authentication Error=>${error.toString()}');
    emit(RegisterErrorState());
  });
  }
  void setUserData({
  required String uId,
}){
    emit(SetDataLoadingRegisterState());
    UserModel userModel = UserModel(
      uId: uId,
      name: nameController.text,
      phone: passwordController.text,
      address: addressController.text,
      status: 'status',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
          emit(SetDataRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SetDataRegisterErrorState());
    });
  }
}