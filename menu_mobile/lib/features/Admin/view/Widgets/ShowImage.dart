import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatefulWidget {
  final String imagePath;
  const ShowImage({Key? key, required this.imagePath}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ShowImageState();
  }
}

class ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
            imageProvider: NetworkImage(
      widget.imagePath,
    )));
  }
}
