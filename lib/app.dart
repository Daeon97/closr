import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/screens.dart';
import 'cubits/cubits.dart';
import 'repos/repos.dart';
import 'utils/utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: _repoProviders,
        child: MultiBlocProvider(
          providers: _blocProviders,
          child: MaterialApp(
            theme: ThemeRepo.themeData,
            routes: _routes,
          ),
        ),
      );

  List<RepositoryProvider> get _repoProviders => [
        RepositoryProvider<AuthRepo>(
          create: (_) => AuthRepo(),
        ),
        RepositoryProvider<DatabaseRepo>(
          create: (_) => DatabaseRepo(),
        ),
      ];

  List<BlocProvider> get _blocProviders => [
        BlocProvider<AuthCubit>(
          create: (ctx) => AuthCubit(ctx.read<AuthRepo>()),
        ),
      ];

  Map<String, Widget Function(BuildContext)> get _routes => {
        defaultScreenRoute: (_) => AuthRepo().currentUser == null
            ? const SelectCategoryScreen()
            : const HomeScreen(),
        selectCategoryScreen: (_) => const SelectCategoryScreen(),
        homeScreenRoute: (_) => const HomeScreen(),
        signInScreenRoute: (_) => const SignInScreen(),
        signUpScreenRoute: (_) => const SignUpScreen(),
      };
}
