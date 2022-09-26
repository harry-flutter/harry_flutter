import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_flutter/application/navigation/app_router.gr.dart';

import '../bloc/harry_collections_bloc.dart';
import '../bloc/user_auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // list of your tab routes
      // routes used here must be declaraed as children
      // routes of /dashboard
      routes: const [
        ElixirsPageRoute(),
        HousesPageRoute(),
        IngridientsPageRoute(),
        SpellsPageRoute(),
        WizardsPageRoute(),
      ],
      builder: (context, child, animation) {
        // obtain the scoped TabsRouter controller using context
        final tabsRouter = AutoTabsRouter.of(context);
        // Here we're building our Scaffold inside of AutoTabsRouter
        // to access the tabsRouter controller provided in this context
        //
        //alterntivly you could use a global key
        return Scaffold(
            body: FadeTransition(
              opacity: animation,
              // the passed child is techinaclly our animated selected-tab page
              child: child,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                // here we switch between tabs
                tabsRouter.setActiveIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                    label: 'Elixirs',
                    icon: Icon(Icons.access_time_filled_sharp)),
                BottomNavigationBarItem(
                    label: 'Houses',
                    icon: Icon(Icons.access_time_filled_sharp)),
                BottomNavigationBarItem(
                    label: 'Ingridients',
                    icon: Icon(Icons.access_time_filled_sharp)),
              ],
            ));
      },
    );
  }
/*   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Flutter'),
      ),
      body: BlocBuilder<HarryCollectionsBloc, HarryCollectionsState>(
        builder: (context, state) {
          final content = state.when(
            initial: () {
              return const Text('Initial state.');
            },
            loading: () {
              return const CircularProgressIndicator();
            },
            loaded: ((data) {
              return Text('Loading done. ${data.length} items to display.');
            }),
            error: (msg) {
              return Text('Error: $msg.');
            },
          );

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: content,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: const Text('Выйти'),
                onTap: () {
                  final userAuthBloc = context.read<UserAuthBloc>();
                  userAuthBloc.add(const UserAuthEvent.logout());
                },
              ),
            ],
          );
        },
      ),
    );
  } */
}
