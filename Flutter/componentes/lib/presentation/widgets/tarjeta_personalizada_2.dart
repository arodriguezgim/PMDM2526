import 'package:flutter/material.dart';

class TarjetaPersonalizada2 extends StatelessWidget {
  const TarjetaPersonalizada2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image(
            image: NetworkImage('https://thumbs.dreamstime.com/b/paisaje-id%C3%ADlico-del-verano-con-el-lago-claro-de-la-monta%C3%B1a-en-las-monta%C3%B1as-45054687.jpg')
            )
        ],
      ),
    );
  }
}