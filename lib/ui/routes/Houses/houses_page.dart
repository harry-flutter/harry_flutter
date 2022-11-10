import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';
import '../../../application/injection_module/injection_container.dart';
import '../../../application/navigation/app_router.gr.dart';
import '../../../data/repositories/settings_repository.dart';

class HousesPage extends StatefulWidget {
  const HousesPage({Key? key}) : super(key: key);

  @override
  State<HousesPage> createState() => _HousesPageState();
}

class _HousesPageState extends State<HousesPage> {
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
            final houses = data.houses;

            return Column(
              children: [
                _renderHeader(context),
                Expanded(
                  child: Scrollbar(
                    controller: _controller,
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: ((BuildContext context, int index) {
                        final item = houses[index];
                        return ListTile(
                          title: Text(
                            item.name ?? 'Empty name',
                            style: const TextStyle(fontSize: 20.0),
                          ),
                          trailing: Text(item.founder ?? ''),
                          subtitle: Text(item.commonRoom ?? ''),
                          isThreeLine: true,
                          onTap: () async {
                            await context.router
                                .push(HouseDetailPageRoute(house: item));
                          },
                        );
                      }),
                      itemCount: houses.length,
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
        Text('Houses', style: TextStyle(fontSize: 26.0)),
      ],
    ),
  );
}
