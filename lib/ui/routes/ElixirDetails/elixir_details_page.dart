import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
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
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _renderHeader(context),
            _renderContent(),
          ],
        ),
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
                child: isFavorite == true ? const Icon(Icons.star) : const Icon(Icons.star_border),
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
          _renderImage(),
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

  Image _renderImage() {
    // Генерируем псевдоуникальный индекс картинки на основе поля id.
    final id = widget.elixir!.id;
    final picId = id != null ? id.codeUnits.sum : 1;
    final elixirsLength = ImagePaths.elixirs.elixirList.length;
    final index = picId % elixirsLength;
    final img = ImagePaths.elixirs.elixirList[index];

    return Image.asset(img, height: 300);
  }
}
