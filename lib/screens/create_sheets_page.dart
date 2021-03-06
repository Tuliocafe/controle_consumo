import 'package:controle_consumo/model/user.dart';
import 'package:controle_consumo/sheets/user_sheets.dart';
import 'package:controle_consumo/widget/botton_widget.dart';
import 'package:controle_consumo/widget/user_form_widget.dart';
import 'package:flutter/material.dart';

class CreateSheetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Cadastro Consumo'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: UserFormWidget(
              onSavedUser: (user) async {
                final id = await UserSheets.getRowCount() + 1;
                final newUser = user.copy(id: id);

                await UserSheets.insert([newUser.toJson()]);
              },
            ),
          ),
        ),
      );

  // Future insertUsers() async {
  //   final users = [
  //     User(id: 4, pessoa: 'Tulio', item: 'HotDog', valor: '15.00'),
  //   ];
  //
  //   final jsonUsers = users.map((user) => user.toJson()).toList();
  //
  //   await UserSheets.insert(jsonUsers);
  // }
}
