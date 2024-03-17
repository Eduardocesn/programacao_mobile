import 'package:flutter/material.dart';
import '../components/custom_card.dart';
import '../tools/favorite_data.dart';
import '../components/bottom_bar.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.searchedFiles});
  final List<List<String>> searchedFiles;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Resultados'),
      ),
      body: Center(
          child: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Erro ao carregar dados");
              } else {
                List<List<String>>? dadosFavoritos = snapshot.data;
                if (dadosFavoritos != null){
                  return ListView.builder(
                      itemCount: searchedFiles.length,
                      itemBuilder: (context, index){
                        return CustomCard(
                            args: searchedFiles[index],
                            dadosFavoritos: dadosFavoritos,
                            favoriteScreen: false
                        );
                      }
                  );
                } else {
                  return SizedBox();
                }
              }
            },

          ),
      ),
      bottomNavigationBar: bottomBar(),
    );
  }
}