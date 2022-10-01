import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../data/models/elixir.dart';

class ElixirsPage extends StatelessWidget {
  const ElixirsPage({Key? key}) : super(key: key);

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
            return ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                final item = data.elixirs[index];
                return ListTile(
                  title: Text(item.name != null ? item.name as String : ''),
                  trailing: _renderDifficultyLabel(item),
                  subtitle: _renderIngredientsLabel(item),
                  isThreeLine: true,
                );
              }),
              itemCount: data.elixirs.length,
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
        label = '***';
        break;
      case 'Advanced':
        label = '*****';
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
