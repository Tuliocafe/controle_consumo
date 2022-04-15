import 'package:controle_consumo/service/auth_service.dart';
import 'package:controle_consumo/sheets/user_sheet_cadastro.dart';
import 'package:controle_consumo/sheets/user_sheets.dart';
import 'package:controle_consumo/widget/auth_check_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await UserSheetsCadastro.initCadastro();
  //Nao deveria ter duas planilhas cadastradas, no inicio nao sabia fazer e fiz isso
  //Hoje já sei manter em somente uma, mas ainda nao tive tempo de fazelo
  await UserSheets.init();

  runApp(
    MultiProvider(providers: [
      // ainda estou aprendendo como usa.
      ChangeNotifierProvider(create: (context) => AuthService()),

    ], child: MyApp()),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Controle Consumo',
    theme: ThemeData(primarySwatch: Colors.blue),
    // home: ModifySheetsPage(),
    // home: CreateSheetsPage(),
    // home: Dashboard(),
    home: AuthCheckWidget(),
    //   home: LearnFirebase(),
  );
}