import 'dart:convert';

class UserFieldsCadastro{
  // static final String id = 'id';
  static final String loja = 'loja';
  static final String funcionario = 'funcionario';

  static List<String> getFields() => [loja,funcionario];
}


class UserCadastro {
  // final int? id;
  final String? loja;
  final String? funcionario;



  const UserCadastro({this.loja,this.funcionario});

  UserCadastro copy({
    // int? id,
    String? loja,
    String? funcionario,


  }) =>
      UserCadastro(
        // id: id ?? this.id,
        loja: loja ?? this.loja,
        funcionario: funcionario ?? this.funcionario
      );

  static UserCadastro fromJson(Map<String, dynamic> json) => UserCadastro(
    // id: jsonDecode(json[UserFieldsCadastro.id]),
    loja: json[UserFieldsCadastro.loja],
    funcionario: json[UserFieldsCadastro.funcionario],

  );

  Map<String,dynamic> toJson() =>{
    // UserFieldsCadastro.id: id,
    UserFieldsCadastro.loja: loja,
    UserFieldsCadastro.funcionario: funcionario,
  };

}

