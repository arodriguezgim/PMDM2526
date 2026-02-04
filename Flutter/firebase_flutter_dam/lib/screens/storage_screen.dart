import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StorageScreen extends StatefulWidget {
   
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {

  PlatformFile? selectedFile;

  Future _seleccionarArchivo() async {
    final result = await FilePicker.platform.pickFiles();
    if ( result == null ) return;
    setState(() {
      selectedFile = result.files.first;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subir Archivo'),), 
      body: Center(
         child:Column(
          mainAxisAlignment: .center,
          children: [

            if ( selectedFile != null ) Container(
              height: 350,
              color: Colors.blue[100],
              child: Text('Archivo seleccionado: ${selectedFile!.name}')
              /* Image.file( 
                File(selectedFile!.path!),
                fit: .cover,
                width: double.infinity,
              ),*/
            ) else 
            Icon(Icons.cloud_upload, size: 100, color: Colors.blue,),


            SizedBox(height: 24,),
            Text('Aquí puedes subir archivos a la nube', style: TextStyle(fontSize: 18),),




            SizedBox(height: 24,),
            ElevatedButton(onPressed: _seleccionarArchivo,
             child: Text('Seleccionar archivo')),
            SizedBox(height: 24,),
            ElevatedButton(onPressed: () {
              // Lógica para SUBIR archivos
            },
             child: Text('Subir archivo')),
          ],
         )
      ),
    );
  }
}