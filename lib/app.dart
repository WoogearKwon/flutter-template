import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'barrel.dart';

class _InheritedApplication extends InheritedWidget {
  final _ApplicationState state;

  _InheritedApplication({
    Key key,
    @required this.state,
    @required Widget child,
  })  : assert(state != null),
        assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedApplication oldWidget) {
    return oldWidget.state != state;
  }
}

class Application extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final RouteFactory routeFactory;

  Application({
    @required this.navigatorKey,
    @required this.routeFactory,
  })  : assert(navigatorKey != null),
        assert(routeFactory != null);

  @override
  _ApplicationState createState() => _ApplicationState();

  static _ApplicationState of(BuildContext context) {
    final widget =
    context.dependOnInheritedWidgetOfExactType<_InheritedApplication>();

    return widget.state;
  }
}

class _ApplicationState extends State<Application> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _appLifecycleState = state;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedApplication(
      state: this,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: ThemeData.light().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palettes.white,
        ),
        darkTheme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.light,
        onGenerateRoute: widget.routeFactory,
        navigatorKey: widget.navigatorKey,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

