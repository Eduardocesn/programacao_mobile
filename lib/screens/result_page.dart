import 'package:flutter/material.dart';
import '../components/custom_card.dart';
import 'package:favorite_data/favorite_data.dart';
import '../components/bottom_bar.dart';
import 'package:postgres/postgres.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key, required this.nome, required this.edicao, required this.data, required this.dataInicial, required this.dataFinal});
  final String nome;
  final String edicao;
  final String data;
  final String dataInicial;
  final String dataFinal;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<List<dynamic>> dadosFavoritos = [];

  Future<Result?> getDocs() async {
    try {
      final conn = await Connection.open(Endpoint(
        host:'ip',
        database:'diario_recife',
        username: 'postgres',
        password: 'postgres',
        port: 5432
      ),
          settings: ConnectionSettings(sslMode: SslMode.disable),);
      final results = await conn.execute(
          Sql.named("SELECT id, nome, link, file FROM docs "
                    "WHERE (edicao = @edicao OR @edicao = '')"
                    "AND (data_edicao = @data OR @data = '') "
                    "AND ((data_edicao BETWEEN @data_inicial AND @data_final) OR @data_inicial = '' OR @data_final = '') "
                    "AND (content LIKE '%${widget.nome}%' OR @nome = '')"),
          parameters: { 'edicao': widget.edicao,
                        'data': widget.data,
                        'data_inicial': widget.dataInicial,
                        'data_final': widget.dataFinal,
                        'nome': widget.nome },
          );
      dadosFavoritos = await loadData();
      conn.close();
      print(widget.nome);
      return results;
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Resultados'),
      ),
      body: Center(
        child: FutureBuilder(
          future: getDocs(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Erro ${snapshot.error}");
            } else {
              List<List<dynamic>>? docs = snapshot.data;
              if (docs != null){
                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index){
                      List<String> arg = List<String>.from(docs[index]);
                      arg.add(widget.nome);
                      arg.add("");
                      return CustomCard(
                          args: arg,
                          dadosFavoritos: dadosFavoritos,
                          favoriteScreen: false
                      );
                    }
                );
              }
              return Container();
            }
          },
        )
      ),
      bottomNavigationBar: bottomBar(),
    );
  }
}