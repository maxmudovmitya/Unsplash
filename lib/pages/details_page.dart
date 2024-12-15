import 'package:flutter/material.dart';
import 'package:ngdemo14/models/photo_model.dart';

class DetailsPage extends StatefulWidget {
  final Photo? photo;
  const DetailsPage({super.key, this.photo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.photo!.description ?? "No name", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
        )
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(widget.photo!.urls.full, fit: BoxFit.cover, height: double.infinity,)
          ],
        ),
      ),
    );
  }
}
