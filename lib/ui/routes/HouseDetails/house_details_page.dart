import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:harry_flutter/application/assets/images.dart';
import 'package:share_plus/share_plus.dart';
import '../../../data/models/house.dart';

const sharePrefix = 'Бро! Зацени какой этот дом:';

enum HouseNamesEnum {
  gryffindor,
  hufflepuff,
  ravenclaw,
  slytherin,
  unknown,
}

class HouseDetailPage extends StatefulWidget {
  const HouseDetailPage({
    required this.house,
    @QueryParam('isFavorite') this.isFavorite,
    this.onToggleFavorite,
    Key? key,
  }) : super(key: key);

  final House house;
  final bool? isFavorite;
  final void Function(bool value)? onToggleFavorite;

  @override
  State<HouseDetailPage> createState() => _HouseDetailPageState();
}

class _HouseDetailPageState extends State<HouseDetailPage> {
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
                  Share.share('$sharePrefix ${widget.house.name ?? ''}');
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
          _renderImage(widget.house.name ?? ''),
          Text(
            '${widget.house.name}',
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
            'Colors: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.house.houseColours ?? ''),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Animal: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.house.animal ?? ''),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Founder: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.house.founder ?? ''),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Ghost: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(widget.house.ghost ?? ''),
        ],
      ),
    );
  }

  Image _renderImage(String houseName) {
    late String img;
    switch (houseNameMapper(houseName)) {
      case HouseNamesEnum.gryffindor:
        img = ImagePaths.houses.gryffindor;
        break;
      case HouseNamesEnum.hufflepuff:
        img = ImagePaths.houses.hufflepuff;
        break;
      case HouseNamesEnum.ravenclaw:
        img = ImagePaths.houses.ravenclaw;
        break;
      case HouseNamesEnum.slytherin:
        img = ImagePaths.houses.slytherin;
        break;
      default:
        img = ImagePaths.noImage;
    }

    return Image.asset(img, height: 300);
  }

  HouseNamesEnum houseNameMapper(String houseName) {
    String name = houseName.toLowerCase();
    switch (name) {
      case 'gryffindor':
        return HouseNamesEnum.gryffindor;
      case 'hufflepuff':
        return HouseNamesEnum.hufflepuff;
      case 'ravenclaw':
        return HouseNamesEnum.ravenclaw;
      case 'slytherin':
        return HouseNamesEnum.slytherin;
      default:
        return HouseNamesEnum.unknown;
    }
  }
}
