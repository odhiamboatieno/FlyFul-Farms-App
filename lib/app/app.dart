import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/app/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flyful_farms/shared/l10n/app_localizations.dart';
import 'package:flyful_farms/shared/widgets/phone_frame.dart';
import 'package:provider/provider.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(getIt<AuthService>()),
      child: MaterialApp.router(
        title: 'Flyful Farms',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          final isDesktop = MediaQuery.of(context).size.width > 461;
          if (isDesktop && child != null) {
            return PhoneFrame(child: child);
          }
          return child ?? const SizedBox.shrink();
        },
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('sw'),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
