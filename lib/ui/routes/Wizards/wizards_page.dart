import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../data/repositories/settings_repository.dart';

class WizardsPage extends StatefulWidget {
  const WizardsPage({Key? key}) : super(key: key);

  @override
  State<WizardsPage> createState() => _WizardsPageState();
}

class _WizardsPageState extends State<WizardsPage> {
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
            final wizards = data.wizards;

            return Column(
              children: [
                _renderHeader(context),
                Expanded(
                  child: Scrollbar(
                    controller: _controller,
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: ((BuildContext context, int index) {
                        final item = wizards[index];
                        final fullName = '${item.firstName} ${item.lastName}';
                        return ListTile(
                          title: Text(
                            fullName.trim(),
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          trailing: Text(
                            'Elixirs count: ${item.elixirs!.length}',
                          ),
                          onTap: () {},
                        );
                      }),
                      itemCount: wizards.length,
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
        Text('Wizards', style: TextStyle(fontSize: 26.0)),
      ],
    ),
  );
}
