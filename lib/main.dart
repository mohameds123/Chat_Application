import 'package:chat/modules/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  user=FirebaseAuth.instance.currentUser;
  await Firebase.initializeApp().then((value) => {
    print('firebase initialized successfully')
  }).catchError((error){
    print('firebase initialized error=>${error.toString()}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (BuildContext context) => SocialRegisterCubit(),
        ),
        BlocProvider(create: (BuildContext context) => SocialLoginCubit(),
        ),
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUsers()..getUserDataRealTime(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SocialLoginScreen(),
      ),
    );
  }
}

