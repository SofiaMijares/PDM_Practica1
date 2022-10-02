import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
   
const DetailScreen({Key? key}) : super(key: key);
      
    @override
    
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Título de la canción'),
            ),
            body: Column(
              children: [
                // Image()
                const Text('Artista'),
                const Text('Album'),
                const Text('Año'),

                const Divider(),
                Row(
                  children: [
                    //Create 3 buttons with the same size
                    Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Reproducir'))),
                    const SizedBox(width: 10,),
                    Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Descargar'))),
                    const SizedBox(width: 10,),
                    Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Compartir'))),
                  ],
                )
              ],
            )
        );
    }
}