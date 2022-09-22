import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'src/app.dart';
import 'src/bloc/harry_collections_bloc.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final harryCollectionsBloc = HarryCollectionsBloc();

  harryCollectionsBloc.add(const HarryCollectionsEvent.bootstrap());

  runApp(
    BlocProvider(
      create: (BuildContext context) => harryCollectionsBloc,
      child: const MyApp(),
    ),
  );
}
