import 'package:controle_consumo/model/user_cadastro.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsCadastro {
// Estudo como manter a mesma UserSheets ?
// Já sei fazer mas estou sem tempo de ajustar.

  static const _credentials = r'''

''';
  //removi essa informação
  static final _planilhaId = '???';
  static final _Consumo = GSheets(_credentials);
  static Worksheet? _userSheet;



  static Future <Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCountEmail() async{
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow(fromColumn: 3);
    print(lastRow);
    // return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;

  }


  static Future insert(List<Map<String, dynamic>> rowList) async{
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }


  static Future initCadastro() async {
    try {
      final spreadsheet = await _Consumo.spreadsheet(_planilhaId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Cadastro');

      final firstRow = UserFieldsCadastro.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e){
      print('Init Error: $e');
    }
  }



static Future<List<String>?> getByColumn(column) async{
  if (_userSheet == null) return null;

  final cadastro = await _userSheet!.values.column(column, fromRow: 2);
  return cadastro;
}


static Future<List<UserCadastro>> getByemail() async{
  if (_userSheet == null) return <UserCadastro>[];

  final colunaemail = await _userSheet!.values.map.allRows(fromColumn: 3);
  return colunaemail == null ? <UserCadastro>[] : colunaemail.map(UserCadastro.fromJson).toList();
}




  static Future  insertByEmail(value,  row) async{
    if (_userSheet == null) return;

    _userSheet!.values.insertValue(value, column: 3, row: row);
  }


}




