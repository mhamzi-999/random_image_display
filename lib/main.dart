import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'features/random_image/presentation/bloc/random_image_bloc.dart';
import 'features/random_image/presentation/pages/random_image_page.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjection();
  runApp(const AuroraAssignmentApp());
}

class AuroraAssignmentApp extends StatelessWidget {
  const AuroraAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RandomImageBloc>()..add(const RandomImageRequested()),
      child: MaterialApp(
        title: 'Random Image',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        home: const RandomImagePage(),
      ),
    );
  }
}
