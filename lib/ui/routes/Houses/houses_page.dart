import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../data/repositories/settings_repository.dart';

class HousesPage extends StatefulWidget {
  const HousesPage({Key? key}) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
  final settingsRepository = sl<SettingsRepository>();

  late ScrollController _controller;

  List<String> favorites = [];

  @override
  void initState() {
    _controller = ScrollController();

    _getFavorites();
    super.initState();
  }

  void _getFavorites() {
    setState(() {
      favorites = settingsRepository.getFavoriteHouses();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            final houses = data.houses;

            return Column(
              children: [
                _renderHeader(context),
                Expanded(
                  child: LazyLoadScrollView(
                    child: Scrollbar(
                      controller: _controller,
                      child: ListView.builder(
                        controller: _controller,
                        itemBuilder: ((BuildContext context, int index) {
                          final item = houses[index];
                          final isFavorite = favorites.contains(item.id);
                          return ListTile(
                            title: Text(
                              item.name ?? 'Empty name',
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            trailing: Text(item.founder ?? ''),
                            subtitle: Text(item.commonRoom ?? ''),
                            isThreeLine: true,
                            selected: isFavorite,
                            onTap: () {
                              if (isFavorite) {
                                settingsRepository.removeFavoriteHouse(item.id ?? '');
                              } else {
                                settingsRepository.addFavoriteHouse(item.id ?? '');
                              }
                              _getFavorites();
                            },
                          );
                        }),
                        itemCount: houses.length,
                      ),
                    ),
                    onEndOfPage: () {},
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

Widget _renderHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Elixirs', style: TextStyle(fontSize: 26.0)),
      ],
    ),
  );
}
