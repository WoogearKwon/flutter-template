part of 'routes.dart';

class AppNavigator {
  AppNavigator._();

  static Future _navigateTo({
    @required BuildContext context,
    @required String path,
    dynamic data,
    TransitionType transition,
    bool replace = false,
    bool clearStack = false,
  }) {
    assert(context != null);
    assert(path != null);

    FocusScope.of(context).unfocus();

    return Routes.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition ?? TransitionType.native,
      routeSettings: data != null
          ? RouteSettings(
              arguments: data,
            )
          : null,
    );
  }
}
