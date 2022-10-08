import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../application/navigation/app_router.gr.dart';
import '../../../data/models/elixir.dart';
import '../../../data/repositories/settings_repository.dart';
import 'skeleton.dart';

class ElixirsPage extends StatefulWidget {
  const ElixirsPage({Key? key}) : super(key: key);

  @override
  State<ElixirsPage> createState() => _ElixirsPageState();
}

class _ElixirsPageState extends State<ElixirsPage> {
  final settingsRepository = sl<SettingsRepository>();

  late ScrollController _controller;

  String? lastId;
  bool showOnlyFavorites = false;

  SortOrderTypes _orderType = SortOrderTypes.asc;

  List<String> favoriteIds = [];

  @override
  void initState() {
    _controller = ScrollController();

    _getFavorites();
    super.initState();
  }

  void _getFavorites() {
    setState(() {
      favoriteIds = settingsRepository.getFavoriteElixirs();
    });
  }

  void toggleFavoriteMode() {
    setState(() {
      showOnlyFavorites = !showOnlyFavorites;
    });
  }

  List<Elixir> getFilteredList(List<Elixir> elixirs) {
    return showOnlyFavorites ? elixirs.where((element) => favoriteIds.contains(element.id)).toList() : elixirs;
  }

  @override
  Widget build(BuildContext context) {
    final harryCollectionsBloc = context.read<HarryCollectionsBloc>();

    return BlocConsumer<HarryCollectionsBloc, HarryCollectionsState>(
      listener: (context, state) {
        state.mapOrNull(loaded: ((data) {
          final elixirs = getFilteredList(data.elixirs);
          setState(() {
            elixirs.isNotEmpty ? lastId = elixirs.last.id : lastId = null;
          });
        }));
      },
      builder: (context, state) {
        return state.maybeMap(
          orElse: () {
            return const Skeleton();
          },
          loaded: ((data) {
            final elixirs = getFilteredList(data.elixirs);

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
                          final item = elixirs[index];
                          final isFavorite = favoriteIds.contains(item.id);
                          return ListTile(
                            title: Text(item.name ?? 'Empty name'),
                            trailing: _renderDifficultyLabel(item),
                            subtitle: _renderIngredientsLabel(item),
                            isThreeLine: true,
                            selected: isFavorite,
                            onTap: () {
                              onToggleFavorite() {
                                if (isFavorite) {
                                  settingsRepository.removeFavoriteElixir(item.id);
                                } else {
                                  settingsRepository.addFavoriteElixir(item.id);
                                }
                                _getFavorites();
                              }

                              AutoRouter.of(context).push(ElixirDetailsPageRoute(
                                elixir: item,
                                isFavorite: isFavorite,
                                onToggleFavorite: onToggleFavorite,
                              ));
                            },
                          );
                        }),
                        itemCount: elixirs.length,
                      ),
                    ),
                    onEndOfPage: () {
                      if (!showOnlyFavorites) {
                        harryCollectionsBloc.add(HarryCollectionsEvent.pullElixirs(
                          count: 10,
                          lastId: lastId,
                          orderType: _orderType,
                        ));
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _renderHeader(BuildContext context) {
    final harryCollectionsBloc = context.read<HarryCollectionsBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Elixirs', style: TextStyle(fontSize: 26.0)),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => toggleFavoriteMode(),
                  child: showOnlyFavorites ? const Icon(Icons.star) : const Icon(Icons.star_border),
                ),
              ),
              PopupMenuButton<SortOrderTypes>(
                padding: EdgeInsets.zero,
                initialValue: _orderType,
                enabled: !showOnlyFavorites,
                onSelected: (value) {
                  setState(() {
                    _orderType = value;
                    lastId = null;
                  });
                  harryCollectionsBloc.add(
                    HarryCollectionsEvent.pullElixirs(
                      count: 10,
                      lastId: lastId,
                      orderType: value,
                    ),
                  );
                  _scrollToTop();
                },
                itemBuilder: (context) => <PopupMenuItem<SortOrderTypes>>[
                  PopupMenuItem<SortOrderTypes>(
                    value: SortOrderTypes.asc,
                    child: Text(simpleValueToString(
                      context,
                      SortOrderTypes.asc,
                    )),
                  ),
                  PopupMenuItem<SortOrderTypes>(
                    value: SortOrderTypes.desc,
                    child: Text(simpleValueToString(
                      context,
                      SortOrderTypes.desc,
                    )),
                  ),
                ],
                child: Icon(
                  Icons.sort_by_alpha,
                  color: showOnlyFavorites ? Colors.black26 : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String simpleValueToString(BuildContext context, SortOrderTypes value) {
    return {
      SortOrderTypes.asc: 'Ascending order',
      SortOrderTypes.desc: 'Descending order',
    }[value]!;
  }

  Widget _renderDifficultyLabel(Elixir elixir) {
    String label = '?';
    switch (elixir.difficulty) {
      case 'Beginner':
        label = '*';
        break;
      case 'Moderate':
        label = '**';
        break;
      case 'Advanced':
        label = '***';
        break;
      case 'OrdinaryWizardingLevel':
        label = '****';
        break;
    }
    return Text(
      label,
      style: const TextStyle(fontSize: 20.0),
    );
  }

  Widget _renderIngredientsLabel(Elixir elixir) {
    String label = elixir.ingredients!.map((e) => e.name).join(', ');
    return Text(label);
  }

  void _scrollToTop() {
    _controller.jumpTo(0);
  }
}
