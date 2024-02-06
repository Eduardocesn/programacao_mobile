import 'package:flutter/material.dart';

import 'pdf_page.dart';
import 'favorite_data.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key, required this.savedFiles, required this.nameFiles});
  final List<String> savedFiles;
  final List<String> nameFiles;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
  }

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
                      return FavoriteCard(
                        args: item,
                        dadosFavoritos: dadosFavoritos,
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
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(226, 81, 81, 1),
        child: Center(
          child: Text(
            "Diário Oficial de Recife",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteCard extends StatefulWidget {
  FavoriteCard({super.key, required this.args, required this.dadosFavoritos});
  final List<dynamic> args;
  List<List<dynamic>> dadosFavoritos;
  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {

  @override
  Widget build(BuildContext context) {
    bool saved = widget.dadosFavoritos.contains(widget.args);
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerPage()));
        },
        child: Column(
          children: [
            SizedBox( // Constrain the size of the list tile
              height: 100, // Set custom height from constructor
              child: Row( // Row layout for list item content
                children: [
                  Padding( // Padding for the leading widget
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  ),
                  Expanded( // Expanded section for title and subtitle
                    child: Column( // Column layout for title and subtitle
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text left
                      children: [
                        Padding(padding: const EdgeInsets.only(top: 20)),
                        Text(
                          widget.args[4],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing between title and subtitle
                        //Text(widget.args[3].toString()),
                      ],
                    ),
                  ),
                  Padding( // Padding for the trailing widget
                    padding: EdgeInsets.only(right: 12, top: 3, bottom: 3),
                    child: Column(
                        children: [
                          Flexible(
                            child: TextButton(child: Text("Renomear"),
                              onPressed: (){},
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.file_download_rounded),
                                onPressed: (){
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share),
                                onPressed: (){
                                },
                              ),
                              IconButton(
                                icon: saved ?
                                Icon(Icons.favorite) :
                                Icon(Icons.favorite_border),
                                color: Colors.red,
                                onPressed: () async{
                                  setState(() {
                                    // Here we changing the icon.
                                    if(saved){
                                      saved = false;
                                      widget.dadosFavoritos.remove(widget.args);
                                    } else {
                                      saved = true;
                                      //widget.dadosFavoritos.add(widget.args);
                                    }
                                  });
                                  await writeData(widget.dadosFavoritos);
                                },
                              ),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

}
