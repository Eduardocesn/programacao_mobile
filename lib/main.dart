import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'favorite_page.dart';
import 'result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Consulta'),
        ),
        body: SearchScreen(),
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
  TextEditingController editionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController initialDateController = TextEditingController();
  TextEditingController finalDateController = TextEditingController();

  List<String> savedFiles = <String>[];
  List<String> nameFiles = ["Arquivo 1", "Arquivo 2", "Arquivo 3", "Arquivo 4",
    "Arquivo 5","Arquivo 6","Arquivo 7","Arquivo 8","Arquivo 9","Arquivo 10",];

  void clearFields() {
    _searchController.clear();
    editionController.clear();
    dateController.clear();
    initialDateController.clear();
    finalDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Pesquisar por nome',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              )
            ),
          ),
          SizedBox(height: 15),
          TextField(
            controller: editionController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Pesquisar por edição',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                )
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: dateController,
            decoration: InputDecoration(
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
          SizedBox(height: 15),
          Row(
            children: [
              Flexible(child: TextField(
                controller: initialDateController,
                decoration: InputDecoration(
                    hintText: 'Data inicial',
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
                      initialDateController.text = formattedDate; //set foratted date to TextField value.
                    });
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
              ),
              SizedBox(width: 15,),
              Flexible (
                child: TextField(
                controller: finalDateController,
                decoration: InputDecoration(
                    hintText: 'Data final',
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
                      finalDateController.text = formattedDate; //set foratted date to TextField value.
                    });
                  }else{
                    print("Date is not selected");
                  }
                },
              ),
              ),
            ],
          ),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(226, 81, 81, 1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(100,50),
                  ),

              onPressed: () {
                // Implemente a lógica de pesquisa aqui
                print('Nome: ${_searchController.text}');
                print('Edição: ${editionController.text}');
                print('Data: ${dateController.text}');
                print('Data Inicial e Final: ${initialDateController.text} ${finalDateController.text}');
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultScreen(savedFiles: savedFiles, nameFiles: nameFiles,)),
                ).then((value) => clearFields());
              },
              child: Text('Pesquisar'),
              ),
              SizedBox(width:40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen(savedFiles: savedFiles, nameFiles: nameFiles,)),
                  ).then((value) => clearFields());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(226, 81, 81, 1),
                  foregroundColor: Colors.white,
                  minimumSize: Size(100,50),
                ),
                child: Text('Favoritos'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
