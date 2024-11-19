import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traveldart/presentation/pages/main_page.dart';
import 'package:traveldart/presentation/pages/multi_page.dart';
import 'package:traveldart/presentation/pages/result_page.dart';
import 'package:traveldart/presentation/pages/roulette_page.dart';
import 'package:traveldart/presentation/pages/round_make_page.dart';
import 'package:traveldart/presentation/pages/single_page.dart';
import 'package:traveldart/presentation/pages/splash_page.dart';

part 'routes.g.dart';

/// SplashScreen
@TypedGoRoute<SplashRoute>(
  path: SplashRoute.path,
  name: SplashRoute.name,
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  static const String path = '/splash';
  static const String name = 'splash';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const SplashPage());
  }
}

/// SplashScreen
@TypedGoRoute<MainRoute>(
  path: MainRoute.path,
  name: MainRoute.name,
  routes: [
    TypedGoRoute<SingleRoute>(
      path: SingleRoute.path,
      name: SingleRoute.name,
    ),
    TypedGoRoute<MultiRoute>(
      path: MultiRoute.path,
      name: MultiRoute.name,
      routes: [
        TypedGoRoute<RoundMakeRoute>(
          path: RoundMakeRoute.path,
          name: RoundMakeRoute.name,
        ),
      ],
    ),
    TypedGoRoute<ResultRoute>(
      path: ResultRoute.path,
      name: ResultRoute.name,
    ),
  ],
)
@immutable
class MainRoute extends GoRouteData {
  const MainRoute();

  static const String path = '/';
  static const String name = 'main';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const MainPage());
  }
}

class RoundMakeRoute extends GoRouteData {
  const RoundMakeRoute({
    this.gameId,
    this.roundIds,
  });

  final String? gameId;
  final List<int>? roundIds;

  static const String path = 'round';
  static const String name = 'roundMake';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, RoundMakePage(gameId, roundIds));
  }
}

class SingleRoute extends GoRouteData {
  const SingleRoute();

  static const String path = 'single';
  static const String name = 'single';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const SinglePage());
  }
}

class MultiRoute extends GoRouteData {
  const MultiRoute();

  static const String path = 'multi';
  static const String name = 'multi';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const MultiPage());
  }
}

class ResultRoute extends GoRouteData {
  const ResultRoute();

  static const String path = 'result';
  static const String name = 'result';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const ResultPage());
  }
}

@TypedGoRoute<RouletteRoute>(
  path: RouletteRoute.path,
  name: RouletteRoute.name,
)
class RouletteRoute extends GoRouteData {
  const RouletteRoute();
  static const String path = '/roulette';
  static const String name = 'Roulette';
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return defaultPagination(context, state, const RoulettePage());
  }
}

extension AnimationPagination on GoRouteData {
  /// ## FadeTransition : Tween 1.0 to 0.0
  Page<void> defaultPagination(
      BuildContext context, GoRouterState state, Widget child) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(secondaryAnimation),
          child: child,
        );
      },
    );
  }
}
