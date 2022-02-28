// import 'package:controle_consumo/service/auth_service.dart';
// import 'package:flutter/material.dart';
//
// import '../screens/login_page.dart';
//
// class AuthCheckWidget extends StatefulWidget {
//   const AuthCheckWidget({Key? key}) : super(key: key);
//
//   @override
//   _AuthCheckWidgetState createState() => _AuthCheckWidgetState();
// }
//
// class _AuthCheckWidgetState extends State<AuthCheckWidget> {
//   @override
//   Widget build(BuildContext context) {
//     AuthService auth = Provider.of<AuthService>(context);
//
//     if (auth.isLoading)
//       return loading();
//     else if (auth.usuario == null)
//       return LoginPage();
//     else
//       return LoginPage();
//   }
//
//
//   loading(){
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//
// }
//
