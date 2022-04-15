import 'dart:core';
import 'package:controle_consumo/model/user.dart';
import 'package:controle_consumo/sheets/user_sheet_cadastro.dart';
import 'package:controle_consumo/widget/botton_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/email_Validation.dart';
import '../service/auth_service.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  // final ValueChanged<User> onSavedUser;
  final AsyncValueSetter<User>? onSavedUser;
  // final ValueChanged<UserCadastro>? onSevedCadastro;
  final EmailValidation? emailValidation;


  const UserFormWidget({
    Key? key,
    this.user,
    required this.onSavedUser,
    this.emailValidation,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}


class _UserFormWidgetState extends State<UserFormWidget> {
  DateTime datenow = DateTime.now();
  List<String>? cadastroLoja = [];
  List<String>? cadastroFuncionario = [];
  List<String>? listaemail = [];
  String? lojaSelecionada;
  String? funcionarioSelecionado;
  bool ativo = false;

  final formkey = GlobalKey<FormState>();

  // late TextEditingController controllerPessoa;
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

  Future getemail() async {
    final listaemail = await UserSheetsCadastro.getByColumn(3);

    setState(() {
      this.listaemail = listaemail;
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
    // final pessoa = widget.user == null ? '' : widget.user!.pessoa;
    final item = widget.user == null ? '' : widget.user!.item;
    final valor = widget.user == null ? '' : widget.user!.valor;

    setState(() {
      // controllerPessoa = TextEditingController(text: pessoa);
      controllerItem = TextEditingController(text: item);
      controllerValor = TextEditingController(text: valor);
      cadastroFuncionario = cadastroFuncionario;
      datenow = datenow;
      lojaSelecionada = lojaSelecionada;
      funcionarioSelecionado = funcionarioSelecionado;
      listaemail = listaemail;
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
        validator: (value) =>
            value != null && value.isEmpty ? 'Digite Item' : null,
        // validator: (value) =>
        // value != null && !value.contains('@') ? 'Digite E-mail' : null,
      );

  Widget buildSubmit() {
    String dataptbr = DateFormat("dd/MM/yyyy").format(datenow);
    return ButtonWidget(
      text: 'Salvar',
      // onClicked: () {
      //   final form = formkey.currentState!;
      //   final isValid = form.validate();
      //   if (isValid) {
      //     final user = User(
      //       pessoa: funcionarioSelecionado,
      //       item: controllerItem.text,
      //       valor: controllerValor.text,
      //       data: dataptbr,
      //       loja: lojaSelecionada,
      //     );
      //     widget.onSavedUser(user);
      //     controllerPessoa.clear();
      //     controllerItem.clear();
      //     controllerValor.clear();

      onClicked: () async {
        try {
          await getemail();
          setState(() {
            listaemail = listaemail;
          });
          // EmailAutorization validar = EmailAutorization(ativo);
          EmailValidation validar = EmailValidation();
          await validar.emailvalidation(context, listaemail);
          // print('logico que deu merda');
          // print(validar.ativo);
          if (validar.ativo) {
            final form = formkey.currentState!;
            final isValid = form.validate();
            if (isValid) {
              final user = User(
                pessoa: funcionarioSelecionado,
                responsavel: context
                    .read<AuthService>()
                    .usuario
                    ?.email,
                item: controllerItem.text,
                valor: controllerValor.text,
                data: dataptbr,
                loja: lojaSelecionada,
              );
              controllerItem.clear();
              controllerValor.clear();
              await widget.onSavedUser!(user);

              final snackBar = SnackBar(
                content: Text('Cadastrado com SUCESSO'),
                action: SnackBarAction(
                  label: 'Recolher',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else if (!validar.ativo) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => EmailValidation()),
                (route) => false);
          }
        } catch (e) {
          final snackBar = SnackBar(
            content: const Text(
                'Erro, nao foi possivel salvar na planilha, tente novamente mais tarde.'),
            action: SnackBarAction(
              label: 'Recolher',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  Widget buildtexte() {
    return ButtonWidget(

    // for (int i = 0; i <= 6; i++) {
    //   print(teste[i].loja);
    // botao criado para testes.
    // testando um retorno da planilha.
    text: 'Consultar ultimo Lancamento',

        onClicked: () async {
          final snackBar = SnackBar(
            content: Text('Teste'),
                // '${listalancada[3]}  ${listalancada[5]} R\$${listalancada[6]}'),
            action: SnackBarAction(
              label: 'Recolher',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // await getcolumn();
          // setState(() {
          //   //Estudo, melhorar o State
          //   // Sei como ajustar colocar essa informação na initState ou em outro estagio.
          //   listalancada = listalancada;
          // });
          // print(
          //     'Cadastrado Funcionario ${listalancada[3]} Item ${listalancada[5]} valor R\$${listalancada[6]}');
          // final id =  await UserSheetsCadastro.getRowCountEmail();
          //  await getemail();
          // // print();
          //  bool emailexiste = false;
          // print(teste1.length);
          // for (int i = 0; i < teste1.length; i++) {
          //   // print(teste1[i].ativo);
          //   print(teste1[i].email);
          //   if (context.read<AuthService>().usuario?.email == teste1[i].email) {
          //     emailexiste = true;
          //     if (teste1[i].ativo == 'sim') {
          //       print('Liberado para uso');
          //     } else
          //       print('nao liberado');
          //   }
          // }
          // // insertemail(teste, teste1.length +2);
          //
          //
          // if (emailexiste)
          //   print(emailexiste);
          //   else {
          //   await getemail();
          //   insertemail(context.read<AuthService>().usuario?.email,teste1.length +2);
          //   print('nao existe');
          //   print(emailexiste);
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
        decoration: const InputDecoration(
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
}
