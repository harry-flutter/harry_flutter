// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../ui/routes/Elixirs/elixirs_page.dart' as _i2;
import '../../ui/routes/home_page.dart' as _i1;
import '../../ui/routes/Houses/houses_page.dart' as _i3;
import '../../ui/routes/Ingredients/ingridients_page.dart' as _i4;
import '../../ui/routes/Spells/spells_page.dart' as _i5;
import '../../ui/routes/Wizards/wizards_page.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ElixirsPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.ElixirsPage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HousesPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i3.HousesPage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    IngridientsPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i4.IngridientsPage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    SpellsPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i5.SpellsPage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
    WizardsPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i6.WizardsPage(),
        transitionsBuilder: _i7.TransitionsBuilders.fadeIn,
        durationInMilliseconds: 200,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home_page',
          fullMatch: true,
        ),
        _i7.RouteConfig(
          HomePageRoute.name,
          path: '/home_page',
          children: [
            _i7.RouteConfig(
              ElixirsPageRoute.name,
              path: 'elixirs_page',
              parent: HomePageRoute.name,
            ),
            _i7.RouteConfig(
              HousesPageRoute.name,
              path: 'houses-page',
              parent: HomePageRoute.name,
            ),
            _i7.RouteConfig(
              IngridientsPageRoute.name,
              path: 'ingridients-page',
              parent: HomePageRoute.name,
            ),
            _i7.RouteConfig(
              SpellsPageRoute.name,
              path: 'spells-page',
              parent: HomePageRoute.name,
            ),
            _i7.RouteConfig(
              WizardsPageRoute.name,
              path: 'wizards-page',
              parent: HomePageRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i7.PageRouteInfo<void> {
  const HomePageRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomePageRoute.name,
          path: '/home_page',
          initialChildren: children,
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.ElixirsPage]
class ElixirsPageRoute extends _i7.PageRouteInfo<void> {
  const ElixirsPageRoute()
      : super(
          ElixirsPageRoute.name,
          path: 'elixirs_page',
        );

  static const String name = 'ElixirsPageRoute';
}

/// generated route for
/// [_i3.HousesPage]
class HousesPageRoute extends _i7.PageRouteInfo<void> {
  const HousesPageRoute()
      : super(
          HousesPageRoute.name,
          path: 'houses-page',
        );

  static const String name = 'HousesPageRoute';
}

/// generated route for
/// [_i4.IngridientsPage]
class IngridientsPageRoute extends _i7.PageRouteInfo<void> {
  const IngridientsPageRoute()
      : super(
          IngridientsPageRoute.name,
          path: 'ingridients-page',
        );

  static const String name = 'IngridientsPageRoute';
}

/// generated route for
/// [_i5.SpellsPage]
class SpellsPageRoute extends _i7.PageRouteInfo<void> {
  const SpellsPageRoute()
      : super(
          SpellsPageRoute.name,
          path: 'spells-page',
        );

  static const String name = 'SpellsPageRoute';
}

/// generated route for
/// [_i6.WizardsPage]
class WizardsPageRoute extends _i7.PageRouteInfo<void> {
  const WizardsPageRoute()
      : super(
          WizardsPageRoute.name,
          path: 'wizards-page',
        );

  static const String name = 'WizardsPageRoute';
}
