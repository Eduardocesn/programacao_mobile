import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Consulta'),
        ),
        body: SearchScreen(),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Pesquisar por nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              )
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
              onPressed: () {
                // Implemente a lógica de pesquisa aqui
                String searchTerm = _searchController.text;
                print('Realizando pesquisa: $searchTerm');
              },
              child: Text('Pesquisar'),
              ),
              SizedBox(width:40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
                child: Text('Favoritos'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: Center(
        child: ListView(
          children: [
            for (var i=0; i<20; i++)
              CustomCard(),
          ],
        ),
      ),
    );
  }
}


class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
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
                          "Titulo",
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
                        ])
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