import 'package:controle_consumo/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;
  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
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

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  register() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().register(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  // @override
  // public void onStart() {
  //   super.onStart();
  //   // Check if user is signed in (non-null) and update UI accordingly.
  //   FirebaseUser currentUser = mAuth.getCurrentUser();
  //   if(currentUser != null){
  //     reload();
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pit Stop Lanches'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(padding: EdgeInsets.all(8),
                //   child: Image.asset('images/pitstop.JPG'),),
                Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
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
                  padding: EdgeInsets.all(16),
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
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: Size.fromHeight(50),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          register();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (loading)
                          ? [
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ]
                          : [
                        const Icon(Icons.check),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            actionButton,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
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
}
