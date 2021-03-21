import 'package:flutter/material.dart';
import 'package:flutter_apod/models/picture.dart';
import 'package:photo_view/photo_view.dart';

class DetailPage extends StatelessWidget {
  final Picture picture;

  const DetailPage({Key? key, required this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(picture.title),
      ),
      body: Container(
        color: Colors.black,
        child: ClipRect(
          child: PhotoView(
            imageProvider: NetworkImage(picture.url),
          ),
        ),
      ),
    );
  }
}
