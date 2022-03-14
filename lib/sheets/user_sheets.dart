import 'package:controle_consumo/model/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheets {

//  Api usada para teste
//     static const _credentials = r'''{
//   "type": "service_account",
//   "project_id": "controleconsumo",
//   "private_key_id": "54fd99063a4f655dd1339393065e51b264c10ab2",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDHm+8TBbLaNjBm\nHQa55K5d44tLRsS5Zb3/eB6PyvvghzoiTpbpLTOHreQeNlYYfAWcNKt0dK7/kl+o\nboP6Vf6u/nfji2jqKH45Mg1x1SmrqhoLpqPM4+Ufke+YYH8mRjt2QWkkGL9V2C84\n/ag4kRmEpY65CCnhnisG974gTvWiozoMN+fYBmZWCBrmhmNG20VtFsHGzNpV35tj\nDhDQ4ncFCfIB77tE1u1/0YsRbUvxOtfVCd3sZpUErxvWKWTKOPBbPKsc6uqrgLSW\nvtOnYSEtoso/722YjD27xNBy7WbaaLCELqikApH0fWYha2dovYe+dQAm2bDufdLF\nM7QAF7A3AgMBAAECggEAEiICvl4iqLsKe4RAg6uYAXR1x3FW1qa881O0pwhgCD4Q\nlGRCRk1yZG1yDyKNgKznj5CjULF24kWoRfNALwIX4ErClluoPLlP+h8nZINiRTNv\nKUbKk4bSXiNSOivt8QqpRS1dAUf0PbalV46HdRgNUuT9SabJszK8ouXnkiTKIKt8\n80EDEu83HE7Q+kFre/S7qR2iXyMeTSVIVlB1G+or52Qc+1XfYeGRmMo57gtwwjFm\nKWdN3TJpp7RR5Fvxq2e/f1QSkebrGesVB6HWYPmVhuCo4Wg44c0CeN4JwcBjAbKO\ngQn22vwNCK2ayGH/gEWP+ff5QNT8JftXyjVL7GSwNQKBgQD+bbnN+oc1/mUsYuw7\nlnvGpvqxaqJBTQMYDKW5CpQdXlh1zLLBFXKf51haNxD0eDvRfQzp7E9AlKZnQ1E/\nim/eU1Bk1muXH15/cFhrpsde+dBVnHfDTx0sqiZqAS3ImuTpeyIgn3vTiZFLShCB\n07ged2I0pF/vrwiP+sw9WLGiAwKBgQDI14iZtM51DiGY4GwBfSaZ70/3IP+6wbbj\ni7F9MKd/L/hEvYLdQbu+j/0P50Qppoa9H5LcXzHugFUBK5ZKNs1PY3d9uZDOQTLJ\nTAfZVjGMWMBBbDrJT2/fNzjDuF6kajuB6KvfPsYU93YoYwG4UCdvXFxLNM65OtX/\nwGcoJj5cvQKBgCsYsPln71FBBygulW8+fTbX/+zfcB55igWf1s5yMUaMPZWul7TH\nCkR1rmyRmUifuRoyAWb6RS5eP5WMPI3zyCEzoZGDFHRjtuEFSaTqeijnTdfCijLG\nCt4O8DTSgEvTmOTHm69E9HePfNHw+LzU/QIEHNln4mw6DMw+oiveAzC7AoGAbl67\nq7RHzN3yKqAR2pObFfcEW8ufnVL9HXjUFfcZ5PRInAYFF3AbK3LXX9j4hWcFHoNu\nYnpR5z5Q+G6qjagmFZ2UuduzLxV3QlXs7kvGuNjA9nLyr1RfJyyinjQAlpvmjdJ+\nORW3JyiCn1khRdeOhE0eTxn7DKG/nmduiQrTNIUCgYBhPr0LUVR6uPZnrE8z29+w\n6ojtZVUTFMSb2UIFzcjSDWIBk9ChBNCiHuYmWmX/VhWfMcvu4AwIArN7NijYL46+\nW0RnegpGX2u1bkjqgjE7QWPUKeEf2CwYb85e17KAzHbKwft2BsLvHChU/GvUXxpm\nZE+UWDvzW066+ekQrSuOKQ==\n-----END PRIVATE KEY-----\n",
//   "client_email": "controleconsumo@controleconsumo.iam.gserviceaccount.com",
//   "client_id": "108919645242692210483",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/controleconsumo%40controleconsumo.iam.gserviceaccount.com"
// }
    static const _credentials = r'''{
  "type": "service_account",
  "project_id": "controleconsumops",
  "private_key_id": "c33e09a99965ea77b3b9ea05983cea6dfde611d0",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCTbDQLN+07r+mf\nRMkC4rA2wdaHIxuSx6ZTBRPyh3gm+jJMvY+B10NH4/Lu1+Ljkv+b0BQbFgsjoubv\nKQgoqIl0Qi+PzX2i/ziL9KkBVzp/ivf4GstuEg0ACihtfpqbtHNjmYuWjcgU8wty\n7PD5TmV8UGmt0Hkh0bnzvYp787p/pPedU2DraBn/YZUbxUnMAA1TSzREbeMo4BUF\nfTQduq2n2S56JkXXBpcW9+sqby/zieeuFtI25f610DFokiX25wKVbOyPptTvSow6\n5d1F491xZu1EUyaXLGDZAE8dfPqHytXzvRi3bJQtiGvCa/Lsyk1HI52WAvD0zVcQ\njJVObEmRAgMBAAECggEAExh78UwQPZ/+qfO1+dq1KpKXIDAK/UtBHxXUTKEBjkLw\nSwJu2Umx3FkJeaibKhE7bMpaIFwNm1MZiLcO6H1UOKvuDzl14awfffl1/sd2u1ib\n4BZQbXSHHI80R2KT0kFghPE5pIm+9f+5ZuyMFi7ydFTSK4KKfjf1Vz4g9wdODAR2\n6yUPnH5cAQdrR0lSnZABdDLb4/n0X7euuePXcG0qlOMuxtqmTr8gQDFhM+BgSkns\nWa4EIqpnQtQhK/y5IIdfRpHkP1+PcqOYfvX7OHae5Bhb5GlCrXLJ7kCHWNekoC/Z\nQkjS2xntynS//fzb0Bmagz9mGFDYN/aD08DQJfsVhQKBgQDNOPDSqAcVvZQUyGR1\n0IkW+A2HGVERDcF8tMB0E9FEmtvgNQYoTaOMY18q6cr58E1Vsv2ix/ux9faZEMTK\nY4wVCMAOJsCB9lp7bmJpB0jV/ZjHmj/HXLVV3i/v03A5s3HfSPqE14LYJuNvtn71\namdnEIJJ8wAczxGVbd+z3to+JwKBgQC35iZXFwT2pQkcm0Ds3XCouhq438kviov1\nuTaLA+RvK8GixJW4tgF0c44YAC3fBU+cJ9b/OOslenpUhGB9GiutpjaCZM3fWIDA\n1jWk9t4d9TMz2E0ejRSKLepo1nWneQyIeHTMobyIapE/oravIiTRgBB5T6EyB+qg\nTeK2luNFhwKBgQCvn9wQGvW9ODkCtB+s52J6gptpE1RZ6NC9vR25+L+tG22xaQ80\n7IRa/yuRWPR4gppcDcqbRNN0D48SnNQcc6aM1akuMyGp1r7GRMf5I9/EKbtWjf2o\nygDxVCzn66Vt69A2iojBqID0JAudLatmsMF+5RTq3gcpoFdm7tlzX/KbHwKBgGfN\nANcnpyWRAhOjjoIke/LBGVRA/M5Y5adNY/wTtl0J1cKKM/iOw0N39jyV3U6FMOpz\nkmd9OT1uZJ5QGiaDHyRlLV9shsgKrKIsRxtWPQmr3brl3KHiADX+tNF4O/DL4scl\nNshKgqB9hn7k2TkBjMa0Aph22gXjcgwJ6m4lvSMBAoGBAMVoUc9C+WPiiScn0zhh\n4mu8qJezNsdC9shlbEaB01Cz1qQ9N7x2owhPLvXdZw8lk5IJjauBCmFFbdrLuXdf\nI9ebTp9dFnfcqylsYi9+adH5gQSYciIMY4j1Hi/EUAwS8lYn8e4kddiiCL6jfqer\nWWqXlAujH0eg4ltBskoJhBuW\n-----END PRIVATE KEY-----\n",
  "client_email": "pitstopapi@controleconsumops.iam.gserviceaccount.com",
  "client_id": "117138862616320188629",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pitstopapi%40controleconsumops.iam.gserviceaccount.com"
}
  
''';
    //removi essa informação
  // static final _planilhaId = '1SitJZR9Rnh7NNvMLQuBlcwwuQv-117sQoSivLvSBDcM'; api usada para teste
  static final _planilhaId = '1Iz0KDN6xjXHsqXTTGtoneQ2Jpk56lnHrOieTGXV9tlM';
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