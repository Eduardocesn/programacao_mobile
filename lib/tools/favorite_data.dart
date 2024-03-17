import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<List<String>>> loadData() async {
  List<List<String>> resultado = [];
  try{
    final file = await _localFile;
    // Leia o conteúdo do arquivo
    Stream<List<int>> conteudo = file.openRead();

    // Decode o conteúdo como utf8 e converta em linhas
    Stream<String> linhas = conteudo.transform(utf8.decoder).transform(LineSplitter());

    // Processando as linhas
    await for (String linha in linhas) {
      // Divida a linha em partes
      List<String> partes = linha.split(',');

      // Adicione as partes à lista de resultado
      resultado.add(partes);
    }
  } catch (e) {
    print("Erro ao ler arquivo $e");
  }
  return resultado;
}

Future<void> writeData(List<List<String>> dados) async{
  try {
    final file = await _localFile;
    IOSink sink = file.openWrite();

    // Escreva os dados no arquivo
    for (List<String> linha in dados) {
      String linhaFormatada = '${linha.join(',')}\n'; // Adiciona uma quebra de linha
      sink.write(linhaFormatada);
    }

    // Feche o arquivo
    await sink.flush();
    await sink.close();

    print('Dados escritos com sucesso!');
  } catch (e) {
    print("Erro ao escrever no arquivo");
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  final file =  File('$path/favoritos.txt');
  if (!(await file.exists())){
    await file.create();
  }
  return file;
}