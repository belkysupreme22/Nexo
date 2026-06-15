import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/bootstrap/app_bootstrap.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/app_bootstrap_screens.dart';
import 'router/app_router.dart';

class NexoApp extends ConsumerWidget {
  const NexoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrapAsync = ref.watch(appBootstrapProvider);

    return bootstrapAsync.when(
      data: (_) {
        final router = ref.watch(appRouterProvider);

        return MaterialApp.router(
          title: 'Nexo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.darkTheme,
          routerConfig: router,
        );
      },
      loading: () => MaterialApp(
        title: 'Nexo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const AppBootstrapLoadingScreen(),
      ),
      error: (error, stackTrace) => MaterialApp(
        title: 'Nexo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: AppBootstrapErrorScreen(error: error),
      ),
    );
  }
}
