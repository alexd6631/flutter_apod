import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apod/models/picture.dart';
import 'package:flutter_apod/viewmodels/list_pictures_viewmodel.dart';

import 'datail_page.dart';


class PictureGrid extends StatelessWidget {
  final ListPictureViewModel viewModel;
  final int crossAxisCount;

  const PictureGrid(
      {Key? key, required this.viewModel, required this.crossAxisCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.extentBefore >= 0.9 * n.metrics.maxScrollExtent) {
          viewModel.loadMore();
        }
        return false;
      },
      child: Scrollbar(
        child: buildGridView(),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount),
      itemBuilder: (ctx, i) => PictureCell(
        picture: viewModel.pictures[i],
      ),
      itemCount: viewModel.pictures.length,
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemBuilder: (ctx, i) => PictureCell(
        picture: viewModel.pictures[i],
      ),
      itemCount: viewModel.pictures.length,
    );
  }
}

class PictureCell extends StatefulWidget {
  final Picture picture;

  const PictureCell({Key? key, required this.picture}) : super(key: key);

  @override
  _PictureCellState createState() => _PictureCellState();
}

class _PictureCellState extends State<PictureCell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => DetailPage(picture: widget.picture),
            ),
          );
        },
        child: getImage()
    );
  }

  Widget getCachedImage() => CachedNetworkImage(
    imageUrl: widget.picture.thumbnailUrl,
    fit: BoxFit.fill,
  );

  Widget getImage() => Image.network(
    widget.picture.thumbnailUrl,
    fit: BoxFit.fill,
  );

  @override
  void dispose() {
    super.dispose();
    print("dispose Item ${widget.picture.title}");
  }
}