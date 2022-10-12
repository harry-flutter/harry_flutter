import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:harry_flutter/application/assets/images.dart';
import 'package:share_plus/share_plus.dart';

import '../../../data/models/elixir.dart';

const sharePrefix = 'Бро! Зацени какой я Эликсир нашел:';

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _renderHeader(context),
          _renderContent(),
        ],
      ),
    );
  }

  Padding _renderHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 4.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Text(widget.elixir!.name ?? ''),
          Row(
            children: [
              GestureDetector(
                onTap: (() {
                  Share.share('$sharePrefix ${widget.elixir!.name ?? ''}');
                }),
                child: const Icon(Icons.ios_share, size: 20),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: (() {
                  widget.onToggleFavorite!.call(!isFavorite);
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                }),
                child: isFavorite == true
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
              ImagePaths.elixirs.elixirList[
                  Random().nextInt(ImagePaths.elixirs.elixirList.length)],
              height: 300),
          Text(
            '${widget.elixir!.name}',
            style: const TextStyle(
              fontFamily: 'HpHeaderFont',
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Effect: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('${widget.elixir!.effect}'),

          //  Text('${widget.elixir!.sideEffects}'),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Characteristics: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('${widget.elixir!.characteristics}'),
          Text('${widget.elixir!.time}'),
          const Text(
            'Ingridients',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...widget.elixir!.ingredients!.map((e) {
            return Text('${e.name}');
          }).toList(),
        ],
      ),
    );
  }
}
