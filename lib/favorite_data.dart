import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<List<dynamic>>> loadData() async {
  try{
    final file = await _localFile;
    final contents = await file.readAsString();

    List<dynamic> listaDinamica = jsonDecode(contents);
    List<List<dynamic>> listaListas = listaDinamica
        .map((lista) => (lista as List<dynamic>).map((e) => [0,1,3].contains(lista.indexOf(e)) ? e as int : e as String).toList())
        .toList();
    return listaListas;
  } catch (e) {
    print("Erro ao ler arquivo $e");
    return [];
  }
}

Future<void> writeData(List<List<dynamic>> dados) async{
  try {
    final file = await _localFile;
    String contents = jsonEncode(dados);
    await file.writeAsString(contents);
  } catch (e) {
    print("Erro ao escrever no arquivo");
  }
}
Future<String> get _localPath async {
  final directory = await getDownloadsDirectory();
  if(directory != null){
    return directory.path;
  }else{
    return "";
  }
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/favoritos.txt');
}