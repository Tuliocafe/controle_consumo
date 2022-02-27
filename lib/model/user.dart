import 'dart:convert';

class UserFields{
  static final String id = 'id';
  static final String responsavel = 'responsavel';
  static final String data = 'data';
  static final String pessoa = 'pessoa';
  static final String loja = 'loja';
  static final String item = 'item';
  static final String valor = 'valor';

  static List<String> getFields() => [id,responsavel,data, pessoa, loja, item, valor];
}


class User {
  final int? id;
  final String? responsavel;
  final String? data;
  final String? pessoa;
  final String? loja;
  final String? item;
  final String? valor;


   const User({this.id, this.responsavel, this.data, this.pessoa, this.loja, this.valor, this.item});

  User copy({
    int? id,
    String? responsavel,
    String? data,
    String? pessoa,
    String? loja,
    String? item,
    String? valor,

  }) =>
    User(
      id: id ?? this.id,
      responsavel: responsavel ?? this.responsavel,
      data: data ?? this.data,
      pessoa: pessoa ?? this.pessoa,
      loja: loja ?? this.loja,
      item: item ?? this.item,
      valor: valor ?? this.valor,
    );

   static User fromJson(Map<String, dynamic> json) => User(
      id: jsonDecode(json[UserFields.id]),
      responsavel: json[UserFields.responsavel],
      data: json[UserFields.data],
      pessoa: json[UserFields.pessoa],
     loja: json[UserFields.loja],
     item: json[UserFields.item],
     valor: json[UserFields.valor],
   );

  Map<String,dynamic> toJson() =>{
    UserFields.id: id,
    UserFields.data: data,
    UserFields.responsavel: responsavel,
    UserFields.pessoa: pessoa,
    UserFields.loja: loja,
    UserFields.item: item,
    UserFields.valor: valor,
  };

}

