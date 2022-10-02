import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/harry_collections_bloc.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({Key? key}) : super(key: key);

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
            return ListView.builder(
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
                  onTap: () => print('House: $item'),
                );
              }),
              itemCount: houses.length,
            );
          }),
        );
      },
    );
  }
}
