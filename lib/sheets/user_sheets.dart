import 'package:controle_consumo/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheets {


    static const _credentials = r'''
  
''';
    //removi essa informação
  static final _planilhaId = '???';
  static final _Consumo = GSheets(_credentials);
  static Worksheet? _userSheet;




  static Future init() async {

    try {
      final spreadsheet = await _Consumo.spreadsheet(_planilhaId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Consumo');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e){
      print('Init Error: $e');
    }
  }

  static Future <Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title,
      }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async{
    if (_userSheet == null) return 0;

    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }


  static Future<List<User>> getAll() async{
    if (_userSheet == null) return <User>[];

    final users = await _userSheet!.values.map.allRows();
    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }


    static Future<List<String>?> getAllcolumn() async{
    //Preciso melhorar isso, fiz para tentar entender.
    // estou usando uma lista ao invez do map

      final users = await _userSheet!.values.lastRow();
      return users;
    }


  static Future insert(List<Map<String, dynamic>> rowList) async{
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}




// static Future<List<User>> getAllcolumn() async{
// if (_userSheet == null) return <User>[];
//
// final users = await _userSheet!.values.map.allColumns();
// return users == null ? <User>[] : users.map(User.fromJson).toList();
// }