import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apod/ui/picture_list.dart';
import 'package:flutter_apod/viewmodels/list_pictures_viewmodel.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _GridSettings(),
      child: _MainPageBody(),
    );
  }
}

class _MainPageBody extends StatelessWidget {
  static final supportedSizes = [3, 4, 5, 6, 7];

  const _MainPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer2<ListPictureViewModel, _GridSettings>(
        builder: (ctx, vm, gs, child) => PictureGrid(
          viewModel: vm,
          crossAxisCount: gs.columns,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Astronomy Picture of the Day"),
      actions: [
        PopupMenuButton(
          onSelected: (i) {
            context.read<_GridSettings>().columns = i as int;
          },
          itemBuilder: (ctx) => supportedSizes
              .map((i) => PopupMenuItem(value: i, child: Text("$i")))
              .toList(),
        )
      ],
    );
  }
}



class _GridSettings extends ChangeNotifier {
  int _columns = 3;

  int get columns => _columns;

  set columns(int value) {
    _columns = value;
    notifyListeners();
  }
}
