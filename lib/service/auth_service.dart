import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  bool isValid = false;


  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    print(_auth.currentUser);
    notifyListeners();
  }

  // Future getemail() async{
  //   final listemail = await UserSheetsCadastro.getByemail();
  //
  //   this.listemail = listemail;
  // }
  //
  // void insertemail(value, row) async {
  //
  //   await UserSheetsCadastro.insertByEmail(value, row);
  // }
  //
  //
  // emailvalidation(emailautentiado) {
  //   ativo = false;
  //   for (int i = 0; i < listemail.length; i++) {
  //     if ((emailautentiado) == listemail[i].email) {
  //       if (listemail[i].ativo == 'sim') {
  //         print('agora deu');
  //         ativo = true;
  //       }else{
  //         print('Tem que aguardar vc ser registado');
  //       }
  //     }
  //
  //     }
  //   if (!ativo) {
  //     criatemail();
  //   }
  //   notifyListeners();
  //   }
  //
  // criatemail() {
  //   if (!ativo) {
  //     getemail();
  //     insertemail(_auth.currentUser, listemail.length + 2);
  //   }
  // }

  // Future getemail() async {
  //   final listemail = await UserSheetsCadastro.getByemail();
  //
  //   setState(() {
  //     this.listemail = listemail;
  //   });
  // }


  // _emailvalidation(BuildContext context) {
  //   emailexiste = false;
  //   ativo = false;
  //   for (int i = 0; i < listemail.length; i++) {
  //     // print(listemail[i].email);
  //     if ((context.read<AuthService>().usuario
  //         ?.email) == listemail[i].email) {
  //       emailexiste = true;
  //       if (listemail[i].ativo == 'sim') {
  //         ativo = true;
  //         print('agora deu');
  //         return true;
  //       }
  //     }
  //   }
  // }


  register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  login(String email, String password) async {
    //Ainda vou ajustar a questao de Exceptions
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Favor Cadastrar.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
