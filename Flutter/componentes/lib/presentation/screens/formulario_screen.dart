import 'package:flutter/material.dart';

class FormularioScreen extends StatelessWidget {
   
  const FormularioScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario'),), 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                initialValue: 'Alberto R.',
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                onChanged: ( value){
                  print( value );
                } ,
              )
            ],
          ),
        ),
      )
    );
  }
}