abstract class RegisterState{}

class InitialRegisterState extends RegisterState{}

class LoadingRegisterState extends RegisterState{}

class RegisterSuccessState extends RegisterState{}

class RegisterErrorState extends RegisterState{}

class SetDataLoadingRegisterState extends RegisterState{}

class SetDataRegisterSuccessState extends RegisterState{}

class SetDataRegisterErrorState extends RegisterState{}