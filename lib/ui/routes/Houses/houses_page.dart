import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../application/navigation/app_router.gr.dart';
import '../../../data/models/house.dart';
import '../../../data/repositories/settings_repository.dart';

class HousesPage extends StatefulWidget {
  const HousesPage({Key? key}) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  final settingsRepository = sl<SettingsRepository>();

  late ScrollController _controller;

  bool showOnlyFavorites = false;

  List<String> favoriteIds = [];

  @override
  void initState() {
    _controller = ScrollController();

    _getFavorites();
    super.initState();
  }

  void _getFavorites() {
    setState(() {
      favoriteIds = settingsRepository.getFavoriteHouses();
    });
  }

  void toggleFavoriteMode() {
    setState(() {
      showOnlyFavorites = !showOnlyFavorites;
    });
  }

  List<House> getFilteredList(List<House> elixirs) {
    return showOnlyFavorites ? elixirs.where((element) => favoriteIds.contains(element.id)).toList() : elixirs;
  }

  @override
  Widget build(BuildContext context) {
    final harryCollectionsBloc = context.read<HarryCollectionsBloc>();

    return BlocBuilder<HarryCollectionsBloc, HarryCollectionsState>(
      builder: (context, state) {
        return state.maybeMap(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
          loaded: ((data) {
            final houses = getFilteredList(data.houses);

            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  _renderHeader(context, harryCollectionsBloc),
                  _renderContent(houses, harryCollectionsBloc),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _renderHeader(BuildContext context, HarryCollectionsBloc harryCollectionsBloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Houses', style: TextStyle(fontSize: 26.0)),
          Row(
            children: [
              GestureDetector(
                onTap: toggleFavoriteMode,
                child: showOnlyFavorites ? const Icon(Icons.star) : const Icon(Icons.star_border),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderContent(List<House> houses, HarryCollectionsBloc harryCollectionsBloc) {
    return Expanded(
      child: Scrollbar(
        controller: _controller,
        child: ListView.builder(
          controller: _controller,
          itemBuilder: ((BuildContext context, int index) {
            final item = houses[index];
            final isFavorite = favoriteIds.contains(item.id);
            return ListTile(
              title: Text(
                item.name ?? 'Empty name',
                style: const TextStyle(fontSize: 20.0),
              ),
              trailing: Text(item.founder ?? ''),
              subtitle: Text(item.commonRoom ?? ''),
              isThreeLine: true,
              selected: isFavorite,
              onTap: () async {
                onToggleFavorite(bool newValue) {
                  if (newValue != isFavorite) {
                    if (newValue) {
                      settingsRepository.addFavoriteHouse(item.id);
                    } else {
                      settingsRepository.removeFavoriteHouse(item.id);
                    }
                  }
                }

                await context.router.push(HouseDetailPageRoute(
                  house: item,
                  isFavorite: isFavorite,
                  onToggleFavorite: onToggleFavorite,
                ));

                _getFavorites();
              },
            );
          }),
          itemCount: houses.length,
        ),
      ),
    );
  }
}
