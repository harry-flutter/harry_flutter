import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../ui/routes/ElixirDetails/elixir_details_page.dart';
import '../../ui/routes/Elixirs/elixirs_page.dart';
import '../../ui/routes/Houses/houses_page.dart';
import '../../ui/routes/Ingredients/ingridients_page.dart';
import '../../ui/routes/Spells/spells_page.dart';
import '../../ui/routes/Wizards/wizards_page.dart';
import '../../ui/routes/home_page.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route,Screen',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
      children: [
        AutoRoute(
          name: 'ElixirsHomePageRoute',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              page: ElixirsPage,
              initial: true,
            ),
            AutoRoute(
              page: ElixirDetailsPage,
            ),
          ],
        ),
        AutoRoute(
          page: HousesPage,
        ),
        AutoRoute(
          page: IngridientsPage,
        ),
        AutoRoute(
          page: SpellsPage,
        ),
        AutoRoute(
          page: WizardsPage,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
