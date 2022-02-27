import 'package:controle_consumo/model/user.dart';
import 'package:controle_consumo/sheets/user_sheets.dart';
import 'package:controle_consumo/widget/user_form_widget.dart';
import 'package:flutter/material.dart';

class ModifySheetsPage extends StatefulWidget {
  @override
  _ModifySheetsPageState createState() => _ModifySheetsPageState();
}

class _ModifySheetsPageState extends State<ModifySheetsPage> {
  List<User> users = [];
  int index = 1;

  @override
  void initState() {
    super.initState();

    getUsers();
  }

  Future getUsers() async {
    final users = await UserSheets.getAll();

    setState(() {
      this.users = users;
    });
  }
    @override
    Widget build(BuildContext context) => Scaffold(
          appBar: AppBar(
            title: Text('Modificador'),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              children: [
                UserFormWidget(
                  user: users.isEmpty ? null : users[index],
                  onSavedUser: (user) async {},
                )
              ],
            ),
          ),
        );
  }
