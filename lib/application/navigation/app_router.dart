import 'package:auto_route/auto_route.dart';

import '../../ui/routes/Elixirs/elixirs_page.dart';
import '../../ui/routes/Houses/houses_page.dart';
import '../../ui/routes/Ingredients/ingridients_page.dart';
import '../../ui/routes/Spells/spells_page.dart';
import '../../ui/routes/Wizards/wizards_page.dart';
import '../../ui/routes/home_page.dart';

@CustomAutoRouter(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 200,
    replaceInRouteName: 'Page,Route,Screen',
    routes: <AutoRoute>[
      AutoRoute(
        path: '/',
        page: HomePage,
        children: [
          AutoRoute(
            path: "elixirs_page",
            page: ElixirsPage,
          ),
          AutoRoute(
            path: "houses-page",
            page: HousesPage,
          ),
          AutoRoute(
            path: "ingridients-page",
            page: IngridientsPage,
          ),
          AutoRoute(
            path: "spells-page",
            page: SpellsPage,
          ),
          AutoRoute(
            path: "wizards-page",
            page: WizardsPage,
          ),
          RedirectRoute(path: '*', redirectTo: '/'),
        ],
      ),
    ])
class $AppRouter {}
