import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/harry_collections_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<HarryCollectionsBloc, HarryCollectionsState>(
        builder: (context, state) {
          final content = state.when(
            initial: () {
              return const Text('Initial state.');
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            loaded: ((data) {
              return Text('Loading done. ${data.length} items to display.');
            }),
            error: (msg) {
              return Text('Error: $msg.');
            },
          );

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [content],
            ),
          );
        },
      ),
    );
  }
}
