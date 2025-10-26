import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:potential_broccoli/l10n/app_localizations.dart";
import "package:potential_broccoli/models.dart";
import "package:potential_broccoli/models/users.dart";
import "package:potential_broccoli/models/database.dart";
import "package:potential_broccoli/routes.dart";
import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";
import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:sqflite_common_ffi_web/sqflite_ffi_web.dart";

Future<void> preinit() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || kIsWasm) {
    databaseFactory = databaseFactoryFfiWeb;
  } else if (defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.linux) {
    databaseFactory = databaseFactoryFfi;
  }

  sqfliteFfiInit();
}

void main() async {
  await preinit();

  final settings = await Settings.create();
  final database = await DB.create();

  runApp(
    MultiProvider(
      providers: make_providers(settings: settings, database: database),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext bctx) {
    var lm = Provider.of<LocaleModel>(bctx);
    var tmm = Provider.of<ThemeModeModel>(bctx);
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: tmm.theme_mode,
      locale: lm.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      initialRoute: Routes.home.route(),
      routes: predefined_routes,
    );
  }
}

List<SingleChildWidget> make_providers({
  required Settings settings,
  required DB database,
}) {
  return [
    Provider<Settings>(create: (_) => settings),
    Provider<DB>(create: (_) => database),
    ChangeNotifierProvider(create: (_) => LocaleModel(settings: settings)),
    ChangeNotifierProvider(create: (_) => MonthSelectionModel()),
    ChangeNotifierProvider(create: (_) => ThemeModeModel(settings: settings)),
    ChangeNotifierProvider(create: (_) => UsersModel(database: database)),
  ];
}
