import 'constants/app_colors.dart';
import 'constants/characters_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'data/repos/characters_repo.dart';
import 'data/api/characters_web_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_offline/flutter_offline.dart';

void main() {
  initGetIt();
  runApp(
    MyApp(
      appRouter: AppRouter(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharactersCubit(CharactersRepo(CharactersWebServices(Dio()))),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        builder: (context, child) {
          return OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected =
                  !connectivity.contains(ConnectivityResult.none);

              if (connected) {
                return child;
              } else {
                return Scaffold(
                  backgroundColor: AppColors.kMainBackground,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/no_internet.gif',
                          width: 280,
                          height: 280,
                        ),
                        Text(
                          'Can\'t connect .. Check your internet.',
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            child: child!,
          );
        },
      ),
    );
  }
}
