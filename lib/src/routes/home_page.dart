import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:harry_flutter/application/assets/icons.dart';
import 'package:harry_flutter/application/navigation/app_router.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        ElixirsPageRoute(),
        HousesPageRoute(),
        IngridientsPageRoute(),
        SpellsPageRoute(),
        WizardsPageRoute(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.black45,
            selectedItemColor: Colors.black,
            showUnselectedLabels: true,
            selectedFontSize: 15,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: [
              BottomNavigationBarItem(
                  label: 'Elixirs',
                  icon: SvgPicture.asset(
                    IconAssets.menu.elixirs,
                    height: 50,
                  )),
              BottomNavigationBarItem(
                  label: 'Houses',
                  icon: SvgPicture.asset(
                    IconAssets.menu.houses,
                    height: 50,
                  )),
              BottomNavigationBarItem(
                  label: 'Ingridients',
                  icon: SvgPicture.asset(
                    IconAssets.menu.ingridients,
                    height: 50,
                  )),
              BottomNavigationBarItem(
                  label: 'Spells',
                  icon: SvgPicture.asset(
                    IconAssets.menu.spells,
                    height: 50,
                  )),
              BottomNavigationBarItem(
                  label: 'Wizards',
                  icon: SvgPicture.asset(
                    IconAssets.menu.wizards,
                    height: 50,
                  )),
            ],
          ),
        );
      },
    );
  }
}
