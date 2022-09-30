import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../application/bloc/user_auth_bloc.dart';
import '../../application/navigation/app_router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        ElixirsPageRoute(),
        HousesPageRoute(),
        IngridientsPageRoute(),
        SpellsPageRoute(),
        WizardsPageRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        final userAuthBloc = context.read<UserAuthBloc>();

        return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        userAuthBloc.add(const UserAuthEvent.logout());
                      },
                      child: const Icon(Icons.logout_sharp),
                    )),
              ],
            ),
            body: FadeTransition(
              opacity: animation,
              child: SafeArea(child: child),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              },
              showSelectedLabels: false,
              selectedIconTheme: const IconThemeData(color: Colors.black87, opacity: 1.0, size: 50),
              unselectedIconTheme: const IconThemeData(color: Colors.black45, opacity: 1.0, size: 24),
              items: const [
                BottomNavigationBarItem(label: 'Elixirs', icon: FaIcon(FontAwesomeIcons.flask)),
                BottomNavigationBarItem(label: 'Houses', icon: FaIcon(FontAwesomeIcons.fortAwesome)),
                BottomNavigationBarItem(label: 'Ingridients', icon: FaIcon(FontAwesomeIcons.cubesStacked)),
                BottomNavigationBarItem(label: 'Spells', icon: FaIcon(FontAwesomeIcons.wandSparkles)),
                BottomNavigationBarItem(label: 'Wizards', icon: FaIcon(FontAwesomeIcons.hatWizard)),
              ],
            ));
      },
    );
  }
}
