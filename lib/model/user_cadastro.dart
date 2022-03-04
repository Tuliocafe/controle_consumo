class UserFieldsCadastro {
  // static final String id = 'id';
  static const String loja = 'loja';
  static const String funcionario = 'funcionario';
  static const String email = 'email';
  static const String ativo = 'ativo';

  static List<String> getFields() => [loja, funcionario, email, ativo];
}

class UserCadastro {
  // final int? id;
  final String? loja;
  final String? funcionario;
  final String? email;
  final String? ativo;

  const UserCadastro({this.loja, this.funcionario, this.email, this.ativo});

  UserCadastro copy({
    // int? id,
    String? loja,
    String? funcionario,
    String? email,
    String? ativo,
  }) =>
      UserCadastro(
        // id: id ?? this.id,
        loja: loja ?? this.loja,
        funcionario: funcionario ?? this.funcionario,
        email: email ?? this.email,
        ativo: ativo ?? this.ativo,
      );

  static UserCadastro fromJson(Map<String, dynamic> json) => UserCadastro(
        // id: jsonDecode(json[UserFieldsCadastro.id]),
        loja: json[UserFieldsCadastro.loja],
        funcionario: json[UserFieldsCadastro.funcionario],
        email: json[UserFieldsCadastro.email],
        ativo: json[UserFieldsCadastro.ativo],
      );

  Map<String, dynamic> toJson() => {
        // UserFieldsCadastro.id: id,
        UserFieldsCadastro.loja: loja,
        UserFieldsCadastro.funcionario: funcionario,
        UserFieldsCadastro.email: email,
        UserFieldsCadastro.ativo: ativo,
      };
}
