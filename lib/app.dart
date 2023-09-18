import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/redux/middleware/add_sight_middleware.dart';
import 'package:places/redux/middleware/sight_list_screen_middleware.dart';
import 'package:places/redux/reducer/reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final store = Store<AppState>(
      reducer,
      initialState: AppState(),
      middleware: [
        SightListScreenMiddleware(),
        AddSightMiddleware(),
      ],
    );

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Places',
        theme: context.watch<SettingsInteractor>().themeMode,
        home: const SplashScreen(),
      ),
    );
  }
}
