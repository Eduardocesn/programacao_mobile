import 'package:flutter/material.dart';
import '../tools/favorite_data.dart';
import '../components/custom_card.dart';
import '../components/bottom_bar.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favoritos'),
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
              List<List<dynamic>>? dadosFavoritos = snapshot.data;
              if (dadosFavoritos != null){
                return ListView.builder(
                    itemCount: dadosFavoritos.length,
                    itemBuilder: (context, index){
                      List<dynamic> item = dadosFavoritos[index];
                      return CustomCard(
                        args: item,
                        dadosFavoritos: dadosFavoritos,
                        favoriteScreen: true,
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