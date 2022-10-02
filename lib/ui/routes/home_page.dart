import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../application/bloc/user_auth_bloc.dart';
import '../../application/navigation/app_router.gr.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final authBox = Hive.box('auth');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String login = widget.authBox.get('login', defaultValue: '');

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
              title: Text(
                login,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () => userAuthBloc.add(const UserAuthEvent.logout()),
                    child: const Icon(Icons.logout_sharp),
                  ),
                ),
              ],
            ),
            body: FadeTransition(
              opacity: animation,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: child,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                tabsRouter.setActiveIndex(index);
              },
              showSelectedLabels: false,
              selectedIconTheme: const IconThemeData(color: Colors.black87, opacity: 1.0, size: 42),
              unselectedIconTheme: const IconThemeData(color: Colors.black54, opacity: 1.0, size: 22),
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
