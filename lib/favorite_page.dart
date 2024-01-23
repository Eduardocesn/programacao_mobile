import 'package:flutter/material.dart';
import 'pdf_page.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key, required this.savedFiles, required this.nameFiles});
  final List<String> savedFiles;
  final List<String> nameFiles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favoritos'),
      ),
      body: Center(
        child: ListView(
          children: [
            for (var str in savedFiles)
              FavoriteCard(title: str),
          ],
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

class FavoriteCard extends StatelessWidget {
  FavoriteCard({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
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
                          title,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing between title and subtitle
                        Text("Data"),
                      ],
                    ),
                  ),
                  Padding( // Padding for the trailing widget
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        children: [
                          Text("Renomear"),
                          const SizedBox(width:10),
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