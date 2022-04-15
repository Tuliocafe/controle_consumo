import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../service/auth_service.dart';
import '../sheets/user_sheet_cadastro.dart';
import '../widget/botton_widget.dart';
import 'create_sheets_page.dart';

//Nao fiz a validacao denro do usuario, mas criei outro objeto para validar.
//Fiz isso por questoes de aprendizado e devo colocar dentro do usuario em breve.

class EmailValidation extends StatefulWidget {
  // const EmailValidation({Key? key}) : super(key: key);
  bool ativo;
  bool emailexiste;

  // bool ativo = false;
  EmailValidation({
    Key? key,
    this.ativo = false,
    this.emailexiste = false,
  }) : super(key: key);




  @override
  _EmailValidationState createState() {
    return _EmailValidationState();
  }



  // emailvalidation(BuildContext context) {
  //   //estudar: posso colocar um index atrelado ao context ?
  //   emailexiste = false;
  //   ativo = false;
  //   for (int i = 0; i < listemail.length; i++) {
  //     // print(listemail[i].email);
  //     if ((context.read<AuthService>().usuario?.email) == listemail[i].email) {
  //       emailexiste = true;
  //       if (listemail[i].ativo == 'sim') {
  //         ativo = true;
  //         return true;
  //       }
  //     }
  //   }
  //   setState(() {
  //     // Posso criar o initstat e colocar essas funcoes nele, preiso testar
  //     this.ativo = ativo;
  //     this.emailexiste = emailexiste;
  //   });
  // }
  //
  // void insertemail(value, row) async {
  //   await UserSheetsCadastro.insertByEmail(value, row);
  // }
  //
  // criatemail(email) async {
  //   if (!emailexiste) {
  //     await getemail();
  //     insertemail(email, listemail.length + 2);
  //   }
  // }



   emailvalidation(BuildContext context, listemail) {
     emailexiste = false;
     ativo = false;
     for (int i = 0; i < listemail.length; i++) {
       // print(listemail[i].email);
       if ((context.read<AuthService>().usuario?.email) == listemail[i].email) {
         emailexiste = true;
         if (listemail[i].ativo == 'sim') {
           ativo = true;
           print('agora deu');
           return true;
         }
       }
     }
    return true;
  }
}

class _EmailValidationState extends State<EmailValidation> {
  bool ativo = false;
  bool emailexiste = false;
  List listemail = [];
  // List<String>? listemail = [];

  getemail() async {
    final listemail = await UserSheetsCadastro.getusers();

    setState(() {
      this.listemail = listemail;
    });
  }

  emailvalidation(BuildContext context) {
    //estudar: posso colocar um index atrelado ao context ?
    emailexiste = false;
    ativo = false;
    for (int i = 0; i < listemail.length; i++) {
      // print(listemail[i].email);
      if ((context.read<AuthService>().usuario?.email) == listemail[i].email) {
        emailexiste = true;
        if (listemail[i].ativo == 'sim') {
          ativo = true;
          return true;
        }
      }
    }
    setState(() {
      // Posso criar o initstat e colocar essas funcoes nele, preiso testar
      this.ativo = ativo;
      this.emailexiste = emailexiste;
    });
  }

  void insertemail(value, row) async {
    await UserSheetsCadastro.insertByEmail(value, row);
  }

  criatemail(email) async {
    if (!emailexiste) {
      await getemail();
      insertemail(email, listemail.length + 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,

              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  //removi a imagem que estava aqui
                  child: Image.asset('images/pitstop.JPG'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    ' Você esta Logado. Click "Entrar".',// ${context.read<AuthService>().usuario?.email}.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                Container(
                  // height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: ButtonWidget(
                          onClicked: () async {
                            setState(() {
                              this.listemail = listemail;
                            });
                            await getemail();
                            await emailvalidation(context);
                            if (ativo) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CreateSheetsPage()));
                              // print('foi para a pagina certa parabens');
                              // print(auth.ativo);
                            } else if (!emailexiste) {
                              criatemail(auth.usuario?.email);
                            } else {
                              final snackBar = SnackBar(
                                content: Text(
                                    'Usuario não autorizado, favor entrar em contato com administração.'),
                                action: SnackBarAction(
                                  label: 'Recolher',
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          text: 'Entrar',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ButtonWidget(
                          onClicked: () {
                            try { context.read<AuthService>().logout();
                          } catch (e) { Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => MyApp()),
                                    (route) => false); }
                        },
                          text: 'Logout',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8),
                      //   child: ButtonWidget(
                      //     onClicked: () {
                      //       auth.usuario = null;
                      //     },
                      //     text: 'Teste',
                      //   ),
                      // ),
                    ],
                  ),
                )
                //       Container(
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.all(32),
                //         child: const Center(
                //           // child:  RefreshIndicator(
                //           //   onRefresh: {
                //           //     emailvalidation(emailrow);
                //           //     print('teste')
                //           // },
                //             child: Padding(
                //               padding: EdgeInsets.all(24),
                //                   child: ElevatedButton(
                //
                // onPressed: { print('teste');
                //              },
                //         child: Text('Teste'),
              ]),
        ),
      ),
    );
    // ) ,
    //           )
    //         ),
    //       );
  }
}
// print(emailvalidation.length);
// for (int i = 0; i < emailvalidation.length; i++) {
//   // print(teste1[i].ativo);
//   print(emailvalidation[i].email);
//   if (context.read<AuthService>().usuario?.email == emailvalidation[i].email) {
//     emailexiste = true;
//     if (emailvalidation[i].ativo == 'sim') {
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
// else {
//   getemail();
//   insertemail(context.read<AuthService>().usuario?.email,teste1.length +2);
//   print('nao existe');
//   print(emailexiste);
