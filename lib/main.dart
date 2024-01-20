import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  TextEditingController dateController = TextEditingController();
  List<String> savedFiles = <String>[];
  List<String> nameFiles = ["Arquivo 1", "Arquivo 2", "Arquivo 3", "Arquivo 4",
    "Arquivo 5","Arquivo 6","Arquivo 7","Arquivo 8","Arquivo 9","Arquivo 10",];

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
          TextField(
            controller: dateController,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Pesquisar por data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2025)
              );
              if(pickedDate != null ){
                print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                print(formattedDate); //formatted date output using intl package =>  2022-07-04
                //You can format date as per your need

                setState(() {
                  dateController.text = formattedDate; //set foratted date to TextField value.
                });
              }else{
                print("Date is not selected");
              }
            },
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen(savedFiles: savedFiles, nameFiles: nameFiles,)),
                );
              },
              child: Text('Pesquisar'),
              ),
              SizedBox(width:40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen(savedFiles: savedFiles, nameFiles: nameFiles,)),
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
  FavoritesScreen({Key? key, required this.savedFiles, required this.nameFiles}): super(key: key);
  List<String> savedFiles;
  List<String> nameFiles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key, required this.savedFiles, required this.nameFiles}): super(key: key);
  List<String> savedFiles;
  List<String> nameFiles;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
      ),
      body: Center(
        child: ListView(
          children: [
            for (var str in widget.nameFiles)
              ResultCard(title: "$str",
                        saved: widget.savedFiles.contains(str),
                        savedWords: widget.savedFiles,)
          ],
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  FavoriteCard({Key? key, required this.title}): super(key: key);
  final String title;

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


class ResultCard extends StatefulWidget {
  ResultCard({Key? key, required this.title, required this.saved, required this.savedWords}): super(key: key);
  final String title;
  bool saved;
  List<String> savedWords;
  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
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
                          widget.title,
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
                    child: Row(
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
                          icon: widget.saved ?
                                Icon(Icons.favorite) :
                                Icon(Icons.favorite_border),
                          color: Colors.red,
                          onPressed: (){
                            setState(() {
                              widget.saved = !widget.saved;
                              // Here we changing the icon.
                              if(widget.saved){
                                widget.savedWords.add(widget.title);
                              } else {
                                widget.savedWords.remove(widget.title);
                              }
                            });
                          },
                        ),
                      ],
                    ),
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

