import 'package:flutter/material.dart';
import 'package:flyful_farms/app/theme.dart';
import 'package:flyful_farms/app/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flyful_farms/shared/l10n/app_localizations.dart';
import 'package:flyful_farms/shared/widgets/phone_frame.dart';
import 'package:provider/provider.dart';
import 'package:flyful_farms/features/auth/presentation/providers/auth_provider.dart';
import 'package:flyful_farms/features/batches/presentation/providers/batch_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/cage_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/egg_collection_provider.dart';
import 'package:flyful_farms/features/breeding/presentation/providers/maintenance_provider.dart';
import 'package:flyful_farms/features/profile/presentation/providers/sync_provider.dart';
import 'package:flyful_farms/features/records/presentation/providers/record_provider.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/today_provider.dart';
import 'package:flyful_farms/features/dashboard/presentation/providers/farm_provider.dart';
import 'package:flyful_farms/features/feeding/presentation/providers/feeding_provider.dart';
import 'package:flyful_farms/features/harvest/presentation/providers/harvest_provider.dart';
import 'package:flyful_farms/config/di.dart';
import 'package:flyful_farms/features/auth/domain/auth_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    syncController.start();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(getIt<AuthService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<BatchProvider>()..loadBatches(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<CageProvider>()..loadCages(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<FeedingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<HarvestProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<EggCollectionProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<MaintenanceProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<SyncProvider>()..loadPending(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<RecordProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<TodayProvider>()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<FarmProvider>()..load(),
        ),
      ],
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
