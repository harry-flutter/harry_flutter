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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _renderHeader(context),
        _renderContent(),
      ],
    );
  }

  Padding _renderHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              widget.onToggleFavorite!.call(isFavorite);
              Navigator.of(context).pop();
            },
          ),
          Text(widget.elixir!.name ?? ''),
          GestureDetector(
            onTap: (() {
              setState(() {
                isFavorite = !isFavorite;
              });
            }),
            child: isFavorite == true ? const Icon(Icons.star) : const Icon(Icons.star_border),
          ),
        ],
      ),
    );
  }

  Padding _renderContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Elixir id ${widget.elixir!.id}'),
    );
  }
}
