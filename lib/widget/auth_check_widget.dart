import 'dart:js';

import 'package:controle_consumo/service/auth_service.dart';
import 'package:controle_consumo/sheets/user_sheet_cadastro.dart';
import 'package:controle_consumo/widget/user_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/create_sheets_page.dart';
import '../screens/login_page.dart';

class AuthCheckWidget extends StatefulWidget {
  const AuthCheckWidget({Key? key}) : super(key: key);

  @override
  _AuthCheckWidgetState createState() => _AuthCheckWidgetState();
}

class _AuthCheckWidgetState extends State<AuthCheckWidget> {

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return  loading();
    } else if (auth.usuario == null) {
      return LoginPage();
    } else {
      return CreateSheetsPage();
    }
  }


  loading(){
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

