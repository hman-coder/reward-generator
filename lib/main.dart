import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_generator/bloc/categories_cubit.dart';
import 'package:reward_generator/bloc/chance_to_win_cubit.dart';
import 'package:reward_generator/bloc/current_rewards_cubit.dart';
import 'package:reward_generator/bloc/reward_slot_machine_cubit.dart';
import 'package:reward_generator/repository/chances_to_win_repository.dart';
import 'package:reward_generator/repository/current_rewards_repository.dart';
import 'package:reward_generator/ui/main_menu.dart';

const double kfsDefaultFontSize = 24;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RewardGeneratorApp());
}

class RewardGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: kfsDefaultFontSize),
          subtitle1: TextStyle(fontSize: kfsDefaultFontSize),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ChancesToWinCubit>(
              create: (_) =>
                  ChancesToWinCubit(ChancesToWinRepository.factory())),
          BlocProvider<CurrentRewardsCubit>(
              create: (_) =>
                  CurrentRewardsCubit(CurrentRewardsRepository.factory())),
          BlocProvider<CategoriesCubit>(
            create: (_) => CategoriesCubit(),
          )
        ],
        child: BlocProvider(
          create: (context) => RewardSlotMachineCubit(
              chancesToWinCubit: context.read<ChancesToWinCubit>(),
              currentRewardsCubit: context.read<CurrentRewardsCubit>()),
          child: MainMenu(),
        ),
      ),
    );
  }
}
