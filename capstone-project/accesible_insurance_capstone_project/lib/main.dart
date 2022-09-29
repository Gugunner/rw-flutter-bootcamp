import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/observers/logger.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'sign_in/ui/sign_in_screen.dart';

void main() async {
  runApp(ProviderScope(observers: [Logger()], child: const MyApp()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

final appProvider = AppProvider.instance;

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Kiwiik Insurance',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(appProvider.themeProvider.state).state,
      home: const MyHomePage(title: 'Flutter Capstone Project'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SignInScreen();
  }
}
