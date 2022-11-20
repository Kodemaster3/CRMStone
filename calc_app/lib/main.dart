import 'package:calc_app/locator_service.dart';
import 'locator_service.dart' as di;
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/routes.dart';
import 'constant/ui_helper.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderBloc>(create: (context) => sl<OrderBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) {
          final title = AppLocalizations.of(context);
          return title!.appTitle;
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: themeData,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
