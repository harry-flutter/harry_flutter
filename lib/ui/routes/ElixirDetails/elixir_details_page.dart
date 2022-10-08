import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../data/models/elixir.dart';

class ElixirDetailsPage extends StatefulWidget {
  const ElixirDetailsPage({
    @QueryParam('elixir') this.elixir,
    @QueryParam('isFavorite') this.isFavorite,
    this.onToggleFavorite,
    Key? key,
  }) : super(key: key);

  final Elixir? elixir;
  final bool? isFavorite;
  final void Function(bool value)? onToggleFavorite;

  @override
  State<ElixirDetailsPage> createState() => _ElixirDetailsPageState();
}

class _ElixirDetailsPageState extends State<ElixirDetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    isFavorite = widget.isFavorite == true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.onToggleFavorite!.call(isFavorite);
            Navigator.of(context).pop();
          },
        ),
        title: Text(widget.elixir!.name ?? ''),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: (() {
                setState(() {
                  isFavorite = !isFavorite;
                });
              }),
              child: isFavorite == true ? const Icon(Icons.star) : const Icon(Icons.star_border),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Elixir id ${widget.elixir!.id}'),
      ),
    );
  }
}
