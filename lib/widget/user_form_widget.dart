import 'dart:core';
import 'package:controle_consumo/model/user.dart';
import 'package:controle_consumo/sheets/user_sheet_cadastro.dart';
import 'package:controle_consumo/widget/botton_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  DateTime datenow = DateTime.now();
  List<String>? cadastroLoja = [];
  List<String>? cadastroFuncionario = [];
  String? lojaSelecionada;
  String? funcionarioSelecionado;

  final formkey = GlobalKey<FormState>();
  late TextEditingController controllerPessoa;
  late TextEditingController controllerItem;
  late TextEditingController controllerValor;

  @override
  void initState() {
    super.initState();

    initUser();
    // getUsers();

    getLoja();
    getFuncionario();
  }

  // Future getUsers() async {
  //   final cadastroLoja = await UserSheetsCadastro.getAll();
  //   // final cadastroFuncionario = await UserSheetsCadastro.getAllCadastro();
  //   setState(() {
  //
  //     this.cadastroLoja = cadastroLoja;
  //     // this.cadastroFuncionario = cadastroFuncionario;
  //   });
  // }

  Future getLoja() async {
    final cadastroLoja = await UserSheetsCadastro.getByColumn(1);

    setState(() {
      this.cadastroLoja = cadastroLoja;
    });
  }

  Future getFuncionario() async {
    final cadastroFuncionario = await UserSheetsCadastro.getByColumn(2);

    setState(() {
      this.cadastroFuncionario = cadastroFuncionario;
    });
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
    // getUsers();
    getLoja();
    getFuncionario();
  }

  void initUser() {
    final pessoa = widget.user == null ? '' : widget.user!.pessoa;
    final item = widget.user == null ? '' : widget.user!.item;
    final valor = widget.user == null ? '' : widget.user!.valor;

    setState(() {
      controllerPessoa = TextEditingController(text: pessoa);
      controllerItem = TextEditingController(text: item);
      controllerValor = TextEditingController(text: valor);
      cadastroFuncionario = cadastroFuncionario;
      datenow = datenow;
      lojaSelecionada = lojaSelecionada;
      funcionarioSelecionado = funcionarioSelecionado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          buildLoja(),
          const SizedBox(
            height: 16,
          ),
          buildFuncionario(),
          const SizedBox(
            height: 16,
          ),
          // builPessoa(),
          // const SizedBox(
          //   height: 16,
          // ),
          buildItem(),
          const SizedBox(
            height: 16,
          ),
          buildValor(),
          const SizedBox(
            height: 16,
          ),
          buildSubmit(),
          const SizedBox(
            height: 16,
          ),
          buildtexte(),
          const SizedBox(
            height: 16,
          ),
        ]));
  }

  // Widget builPessoa() => TextFormField(
  //   controller: controllerPessoa,
  //   decoration: InputDecoration(
  //     labelText: 'Nome',
  //     border: OutlineInputBorder(),
  //   ),
  //   validator: (value) =>
  //       value != null && value.isEmpty ? 'Digite Nome' : null,
  // );

  Widget buildItem() => TextFormField(
        controller: controllerItem,
        decoration: InputDecoration(
          labelText: 'Produto',
          border: OutlineInputBorder(),
        ),
        // validator: (value) =>
        // value != null && !value.contains('@') ? 'Digite E-mail' : null,
      );

  Widget buildSubmit() {
    String dataptbr = DateFormat("dd/MM/yyyy").format(datenow);
    return ButtonWidget(
      text: 'Salvar',
      onClicked: () {
        final form = formkey.currentState!;
        final isValid = form.validate();
        if (isValid) {
          final user = User(
            pessoa: funcionarioSelecionado,
            item: controllerItem.text,
            valor: controllerValor.text,
            data: dataptbr,
            loja: lojaSelecionada,
          );
          widget.onSavedUser(user);
          controllerPessoa.clear();
          controllerItem.clear();
          controllerValor.clear();
        }
      },
    );
  }

  Widget buildtexte() {
    return ButtonWidget(
        text: 'Teste',
        onClicked: () {
          // for (int i = 0; i <= 6; i++) {
          //   print(teste[i].loja);
          //
          // }
          // print(userCadastroJson[0].loja);
          // print(cadastroFuncionario.map((UserCadastro? tes) => tes?.funcionario));
          print(lojaSelecionada);
          print(cadastroLoja);
          // print(user);
        });
  }

  // Widget buildFlutterBeginner() => SwitchListTile(
  //     value: isBeginner,
  //     title: Text('Verdadero'),
  //     onChanged: (value) => setState(() => isBeginner = value),);

  Widget buildValor() => TextFormField(
        keyboardType: TextInputType.number,
        controller: controllerValor,
        decoration: InputDecoration(
          labelText: 'Valor',
          border: OutlineInputBorder(),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite Valor' : null,
      );

  Widget buildLoja() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
            hint: const Text(
              'Selecione a loja',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            value: lojaSelecionada,
            iconSize: 36,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
            items: cadastroLoja?.map((String userCadastroJson) {
              return DropdownMenuItem<String>(
                value: userCadastroJson,
                child: Text(userCadastroJson),
              );
            }).toList(),
            onChanged: (String? idSelecionado) {
              setState(() {
                lojaSelecionada = idSelecionado;
              });
            },
          )
        ],
      ),
    );
  }

  Widget buildFuncionario() {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.green.shade600,
          // borderRadius: BorderRadius.horizontal(),
          border: Border.all(color: Colors.grey)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: <Widget>[
          DropdownButton<String>(
            hint: const Text(
              'Selecione o Funcionario',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            value: funcionarioSelecionado,
            iconSize: 36,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.black),
            borderRadius: BorderRadius.circular(16),
            items: cadastroFuncionario?.map((String userCadastroJson) {
              return DropdownMenuItem<String>(
                value: userCadastroJson,
                child: Text(userCadastroJson),
              );
            }).toList(),
            onChanged: (String? idSelecionado) {
              setState(() {
                funcionarioSelecionado = idSelecionado;
              });
            },
          )
        ],
      ),
    );
  }

// Widget buildFuncionario() {
//   return Container(
//     decoration: BoxDecoration(
//       // color: Colors.green.shade600,
//       // borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey)),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     child: Row(
//       children: <Widget>[
//         DropdownButton<String>(
//           hint: Text(
//             'Selecione a Funcionario',
//             style: TextStyle(color: Colors.grey, fontSize: 18),
//           ),
//           value: funcionarioSelecionado,
//           // Down Arrow Icon
//           icon: const Icon(
//             Icons.keyboard_arrow_down,
//             color: Colors.grey,
//           ),
//           style: const TextStyle(color: Colors.black),
//           borderRadius: BorderRadius.circular(16),
//           // dropdownColor: Colors.grey,
//           // Array list of items
//           items: cadastroLoja.map((UserCadastro userCadastroJson) {
//             return DropdownMenuItem<String>(
//               value: userCadastroJson.funcionario.toString(),
//               child: Text('${userCadastroJson.funcionario}'),
//               // style: TextStyle(color: Colors.white),
//             );
//           }).toList(),
//
//           onChanged: (String? idSelecionado) {
//             setState(() {
//               funcionarioSelecionado = idSelecionado;
//               print(idSelecionado);
//             });
//           },
//           // After selecting the desired option,it will
//           // change button value to selected value
//         )
//       ],
//     ),
//   );
// }

}
