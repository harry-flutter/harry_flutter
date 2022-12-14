import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../application/bloc/user_auth_bloc.dart';
import '../../application/injection_module/injection_container.dart';
import '../../application/navigation/app_router.gr.dart';
import '../../data/repositories/settings_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final settingsRepository = sl<SettingsRepository>();

  @override
  Widget build(BuildContext context) {
    String login = settingsRepository.getLogin();

    return AutoTabsRouter(
      routes: const [
        ElixirsHomePageRoute(),
        HousesHomePageRoute(),
        IngredientsPageRoute(),
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
            elevation: 0,
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
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            showSelectedLabels: false,
            selectedIconTheme: const IconThemeData(
                color: Colors.black, opacity: 1.0, size: 40),
            selectedFontSize: 16.0,
            unselectedIconTheme: const IconThemeData(
                color: Colors.black54, opacity: 1.0, size: 24),
            items: const [
              BottomNavigationBarItem(
                  label: 'Elixirs', icon: FaIcon(FontAwesomeIcons.flask)),
              BottomNavigationBarItem(
                  label: 'Houses', icon: FaIcon(FontAwesomeIcons.fortAwesome)),
              BottomNavigationBarItem(
                  label: 'Ingredients',
                  icon: FaIcon(FontAwesomeIcons.cubesStacked)),
              BottomNavigationBarItem(
                  label: 'Wizards', icon: FaIcon(FontAwesomeIcons.hatWizard)),
            ],
          ),
        );
      },
    );
  }
}
