import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../data/models/elixir.dart';
import '../../../data/repository/settings_repository.dart';

class ElixirsPage extends StatefulWidget {
  const ElixirsPage({Key? key}) : super(key: key);

  @override
  State<ElixirsPage> createState() => _ElixirsPageState();
}

class _ElixirsPageState extends State<ElixirsPage> {
  final settingsRepository = sl<SettingsRepository>();

  List<String> favorites = [];

  @override
  void initState() {
    _getFavorites();
    super.initState();
  }

  void _getFavorites() {
    setState(() {
      favorites = settingsRepository.getFavoriteElixirs();
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
            final elixirs = data.elixirs;
            return ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                final item = elixirs[index];
                final isFavorite = favorites.contains(item.id);
                return ListTile(
                  title: Text(item.name ?? 'Empty name'),
                  trailing: _renderDifficultyLabel(item),
                  subtitle: _renderIngredientsLabel(item),
                  isThreeLine: true,
                  selected: isFavorite,
                  onTap: () {
                    if (isFavorite) {
                      settingsRepository.removeFavoriteElixir(item.id ?? '');
                    } else {
                      settingsRepository.addFavoriteElixir(item.id ?? '');
                    }
                    _getFavorites();
                  },
                );
              }),
              itemCount: elixirs.length,
            );
          }),
        );
      },
    );
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
}
