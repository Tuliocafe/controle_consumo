import 'package:flutter/material.dart';

List<UserCadastro> emailvalidation = [];



class CheckEmailValidation extends ChangeNotifier{


}




  Future getemail() async{

    final emailvalidation = await UserSheetsCadastro.getByemail();

    setState(() {
      this.emailvalidation = emailvalidation;
    });
  }

    bool emailexiste = false;
    print(emailvalidation.length);
    for (int i = 0; i < emailvalidation.length; i++) {
      // print(teste1[i].ativo);
      print(emailvalidation[i].email);
      if (context.read<AuthService>().usuario?.email == emailvalidation[i].email) {
        emailexiste = true;
        if (emailvalidation[i].ativo == 'sim') {
          print('Liberado para uso');
        } else
          print('nao liberado');
      }
    }
    // insertemail(teste, teste1.length +2);


    if (emailexiste)
      print(emailexiste);
    else {
      getemail();
      insertemail(context.read<AuthService>().usuario?.email,teste1.length +2);
      print('nao existe');
      print(emailexiste);


    return Container();
  }
}







  // final id = await UserSheets.getRowCount() + 1;
  //
  // final newUser = user.copy(id:id);
  //
  // await UserSheets.insert([newUser.toJson()]);



