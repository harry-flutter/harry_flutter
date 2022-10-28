import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../data/repositories/settings_repository.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key? key}) : super(key: key);

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  final settingsRepository = sl<SettingsRepository>();

  late ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();

    super.initState();
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
            final ingredients = data.ingredients;

            return Column(
              children: [
                _renderHeader(context),
                Expanded(
                  child: Scrollbar(
                    controller: _controller,
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: ((BuildContext context, int index) {
                        final item = ingredients[index];
                        return ListTile(
                          title: Text(
                            item.name ?? '',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          onTap: () {},
                          enableFeedback: false,
                        );
                      }),
                      itemCount: ingredients.length,
                    ),
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
        Text('Ingredients', style: TextStyle(fontSize: 26.0)),
      ],
    ),
  );
}
