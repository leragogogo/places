import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/visiting_screen/visiting_screen_bloc.dart';
import 'package:places/data/repository/visiting_screen_repository.dart';
import 'package:provider/provider.dart';

import 'package:places/data/interactor/filter_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data_providers/add_sight_provider.dart';
import 'package:places/data_providers/button_create_provider.dart';
import 'package:places/data_providers/button_save_provider.dart';
import 'package:places/data_providers/choosing_category_provider.dart';
import 'package:places/data_providers/field_empty_provider.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/data_providers/history_provider.dart';
import 'package:places/data_providers/search_provider.dart';
import 'package:places/data_providers/visited_provider.dart';
import 'package:places/data_providers/want_to_visit_provider.dart';

import 'package:places/app.dart';

class DI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => VisitingScreenRepository(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => FiltersProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SettingsInteractor(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChoosingCategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AddSightProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ButtonSaveProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ButtonCreateProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HistoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FieldEmptyProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => WantToVisitProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => VisitedProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PlaceInteractor(),
          ),
          ChangeNotifierProvider(
            create: (_) => SearchInteractor(),
          ),
          ChangeNotifierProvider(
            create: (_) => FilterInteractor(),
          ),
          BlocProvider(
            create: (context) => VisitingScreenBloc(
              visitingScreenRepository:
                  context.read<VisitingScreenRepository>(),
            ),
          ),
        ],
        child: App(),
      ),
    );
  }
}
