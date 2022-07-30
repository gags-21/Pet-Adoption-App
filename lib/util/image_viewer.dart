import 'package:flutter/material.dart';

class PetImageViewer extends StatefulWidget {
  const PetImageViewer({Key? key, required this.imgUrl}) : super(key: key);

  final String imgUrl;

  @override
  State<PetImageViewer> createState() => _PetImageViewerState();
}

class _PetImageViewerState extends State<PetImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          child: Image.network(
            widget.imgUrl,
          ),
        ),
      ),
    );
  }
}
