import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apod/config.dart';
import 'package:flutter_apod/repositories/picture_repository.dart';
import 'package:flutter_apod/viewmodels/list_pictures_viewmodel.dart';
import 'package:flutter_apod/ui/app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<Config>(
        create: (ctx) {
          if (Platform.isMacOS) {
            return desktopConfig;
          } else {
            return mobileConfig;
          }
        }
      ),
      Provider<PictureRepository>(
        create: (ctx) => PictureRepositoryImpl(ctx.read<Config>().baseUrl),
      ),
      ChangeNotifierProvider(
        create: (ctx) => ListPictureViewModel(ctx.read()),
      )
    ],
    child: MyApp(),
  ));
}
