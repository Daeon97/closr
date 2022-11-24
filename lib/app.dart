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
            onGenerateRoute: _routes,
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
        RepositoryProvider<ThemeRepo>(
          create: (_) => const ThemeRepo(),
        ),
      ];

  List<BlocProvider> get _blocProviders => [
        BlocProvider<AuthCubit>(
          create: (ctx) => AuthCubit(ctx.read<AuthRepo>()),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => CategoryCubit(),
        ),
        BlocProvider<ChildDetailsOpsCubit>(
          create: (ctx) => ChildDetailsOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ChildOpsCubit>(
          create: (ctx) => ChildOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ModuleOpsCubit>(
          create: (ctx) => ModuleOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ModuleQuestionsOpsCubit>(
          create: (ctx) => ModuleQuestionsOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ModulesCompletionOpsCubit>(
          create: (ctx) => ModulesCompletionOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ModulesToChildOpsCubit>(
          create: (ctx) => ModulesToChildOpsCubit(ctx.read<DatabaseRepo>()),
        ),
        BlocProvider<ScreenToShowCubit>(
          create: (_) => ScreenToShowCubit(),
        ),
        BlocProvider<UnAssignedModulesOpsCubit>(
          create: (ctx) => UnAssignedModulesOpsCubit(ctx.read<DatabaseRepo>()),
        ),
      ];

  Route<String> _routes(settings) => MaterialPageRoute(
        builder: (ctx) {
          switch (settings.name) {
            case defaultScreenRoute:
              return BlocProvider.of<AuthCubit>(ctx).currentUser == null
                  ? BlocBuilder<ScreenToShowCubit, ScreenToShowState>(
                      builder: (ctx, screenToShowState) {
                        switch (screenToShowState.screenToShow) {
                          case ScreenToShow.selectCategory:
                            return const SelectCategoryScreen();
                          case ScreenToShow.signIn:
                            return const SignInScreen();
                          case ScreenToShow.signUp:
                            return const SignUpScreen();
                        }
                      },
                    )
                  : const HomeScreen();
            case homeScreenRoute:
              return const HomeScreen();
            case addModulesToChildScreenRoute:
              return const AddModulesToChildScreen();
            case selectCategoryScreenRoute:
              return const SelectCategoryScreen();
            case signInScreenRoute:
              return const SignInScreen();
            case signUpScreenRoute:
              return const SignUpScreen();
            case childDetailsScreenRoute:
              return ChildDetailsScreen(settings.arguments as String);
            case quizzesScreenRoute:
              return const QuizzesScreen();
            case quizzesToQuestionsTransitionScreenRoute:
              return QuizzesToQuestionsTransitionScreen(
                  settings.arguments as String);
            case questionsScreenRoute:
              return QuestionsScreen(settings.arguments as String);
            case questionsToQuizzesTransitionScreenRoute:
              return const QuestionsToQuizzesTransitionScreen();
            default:
              return const SizedBox(
                width: nil,
                height: nil,
              );
          }
        },
      );
}
