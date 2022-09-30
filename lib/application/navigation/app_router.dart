import 'package:auto_route/auto_route.dart';
import 'package:harry_flutter/src/routes/Elixirs/elixirs_page.dart';
import 'package:harry_flutter/src/routes/Houses/houses_page.dart';
import 'package:harry_flutter/src/routes/Spells/spells_page.dart';
import 'package:harry_flutter/src/routes/Wizards/wizards_page.dart';
import 'package:harry_flutter/src/routes/home_page.dart';
import '../../src/routes/Ingredients/ingridients_page.dart';

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

          // redirect all other paths
          RedirectRoute(path: '*', redirectTo: '/'),
        ],
      ),
    ])
class $AppRouter {}
