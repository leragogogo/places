import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data_providers/visited_provider.dart';

import 'package:places/app.dart';

class DI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsInteractor(),
        ),
        ChangeNotifierProvider(
          create: (_) => VisitedProvider(),
        ),
      ],
      child: App(),
    );
  }
}
