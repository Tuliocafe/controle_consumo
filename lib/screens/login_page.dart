import 'package:flutter/material.dart';

import '../widget/botton_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        titulo = 'Bem Vindo';
        actionButton = 'Login';
        toggleButton = 'Cadastre aqui.';
      } else {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'voltar ao Login.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'E-mail invalido. Favor digitar e-mail valido.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite sua senha.';
                      } else if (value.length < 6) {
                        return 'Senha deve ter mais de 6 digitos.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ButtonWidget(
                    text: actionButton,
                    onClicked: () {},
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(toggleButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Widget build(BuildContext context) {
//   return Form(
//       key: formKey,
//       child: Column(mainAxisSize: MainAxisSize.min, children: [
//         buildemail(),
//         const SizedBox(
//           height: 16,
//         ),
//         buildpassword(),
//         const SizedBox(
//           height: 16,
//         ),
//         // builPessoa(),
//         // const SizedBox(
//         //   height: 16,
//         // ),
//
//         // buildlogin(),
//         // const SizedBox(
//         //   height: 16,
//         // ),
//       ]));
// }

// Widget buildemail() => TextFormField(
//       controller: email,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'E-mail',
//       ),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'E-mail invalido. Favor digitar e-mail valido.';
//         }
//         return null;
//       },
//     );
//
// Widget buildpassword() => TextFormField(
//       controller: password,
//       obscureText: true,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: 'Senha',
//       ),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Digite sua senha.';
//         } else if (value.length < 6) {
//           return 'Senha deve ter mais de 6 digitos.';
//         }
//         return null;
//       },
//     );
}
