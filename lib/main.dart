import 'package:controle_consumo/screens/create_sheets_page.dart';
import 'package:controle_consumo/screens/modify_sheets_page.dart';
import 'package:controle_consumo/sheets/user_sheet_cadastro.dart';
import 'package:controle_consumo/sheets/user_sheets.dart';
import 'package:flutter/material.dart';

import 'model/teste.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await UserSheetsCadastro.initCadastro();
  await UserSheets.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Controle Consumo',
    theme: ThemeData(primarySwatch: Colors.blue),
    // home: ModifySheetsPage(),
    home: CreateSheetsPage(),
  // home: Something(),
  );

}
