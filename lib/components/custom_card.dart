import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/pdf_page.dart';
import 'package:favorite_data/favorite_data.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class CustomCard extends StatefulWidget {
  CustomCard({super.key, required this.args, required this.dadosFavoritos, required this.favoriteScreen});
  final bool favoriteScreen;
  final List<String> args;
  List<List<dynamic>> dadosFavoritos;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController txtCtr = TextEditingController();
  String downloadProgress = '';
  bool downloading = false;

  @override
  Widget build(BuildContext context) {

    bool saved = false;
    for (var item in widget.dadosFavoritos){
      if(item.contains(widget.args[0])){
        saved = true;
        break;
      }
    }
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewerPage(link:widget.args[2], titulo: widget.args[1], stringBusca: !widget.favoriteScreen ? widget.args[4] : '',)));
        },
        child: Column(
          children: [
            SizedBox( // Constrain the size of the list tile
              height: 120, // Set custom height from constructor
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
                          widget.args[5] == '' ? widget.args[1] : widget.args[5],
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing between title and subtitle
                      ],
                    ),
                  ),
                  Padding( // Padding for the trailing widget
                    padding: EdgeInsets.only(right: 12, top: 3, bottom: 3),
                    child: Column(
                        children: [
                          if (widget.favoriteScreen)
                            Flexible(
                              child: TextButton(child: Text("Renomear"),
                                onPressed: () => setState ((){
                                  displayInputDialog(context);
                                })
                              ),
                            ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.file_download_rounded),
                                onPressed: () async {
                                  downloadFile();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share),
                                onPressed: () async {
                                  String path = await downloadFile();
                                  File file = File(path);
                                  print(path);
                                  if (path != '') {
                                      await Share.shareXFiles(
                                        [XFile(file.path)],
                                      );
                                    } else {
                                      print("Erro em compartilhar");
                                    }

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
                                      for (var elem in widget.dadosFavoritos){
                                        if (elem[0] == widget.args[0]){
                                          widget.dadosFavoritos.remove(elem);
                                          break;
                                        }
                                      }
                                    } else {
                                      saved = true;
                                      widget.dadosFavoritos.add(widget.args);
                                    }
                                  });
                                  await writeData(widget.dadosFavoritos);
                                },
                              ),
                            ],
                          ),
                          if(downloading)
                            Text(downloadProgress),
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
  String? valueText;

  Future<String> downloadFile() async{
    String savePath = '';
    if(await _checkPermission()) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {
        String savename = widget.args[3];
        savePath = "${dir.path}/$savename";
        print("\n\n$savePath\n\n");
        downloading = true;
        try {
          await Dio().download(
          widget.args[2],
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1){
              setState(() {
                downloadProgress = "Baixando: ${(received / total * 100).toStringAsFixed(0)}%";
              });
            }
          }
        );
        ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (content: Text("Download concluído"),
        ));
        downloading = false;
        } on DioException catch(e) { print(e.message); }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (content: Text("Permissão negada")
        ));
      }
    return savePath;
    }

  Future<void> displayInputDialog(BuildContext context) async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(top:30.0),
            child: TextField(
              controller: txtCtr,
              decoration: InputDecoration(
                hintText: "Digite o novo título",
              ),
              onChanged: (value){
                setState(() {
                  valueText = value;
                });
              },
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.green,
                textColor: Colors.white,
                child: Text("OK"),
                onPressed: () {
                  setState(() {
                    if (valueText != null && valueText != ''){
                      for (var elem in widget.dadosFavoritos){
                        if (elem[0] == widget.args[0]){
                          widget.dadosFavoritos.remove(elem);
                          break;
                        }
                      }
                      widget.args[5] = valueText!;
                      widget.dadosFavoritos.add(widget.args);
                      writeData(widget.dadosFavoritos);
                    }
                    Navigator.pop(context);
                  });
                }
            )
          ],
        );
      }
    );
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) return true;
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
}
