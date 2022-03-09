import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

class EmailAutorization {
  bool ativo;
  bool emailexiste = false;

  EmailAutorization(this.ativo);


  emailvalidation(BuildContext context, listemail) async {
    emailexiste = false;
    ativo = false;
    for (int i = 0; i < listemail.length; i++) {
      if ((context
          .read<AuthService>()
          .usuario
          ?.email) == listemail[i].email) {
        emailexiste = true;
        if (listemail[i].ativo == 'sim') {
          ativo = true;
        }
      }
    }
  }
}