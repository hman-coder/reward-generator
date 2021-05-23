import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_generator/bloc/chance_to_win_cubit.dart';

import 'current_rewards_cubit.dart';

class RewardSlotMachineCubit extends Cubit<String> {
  final CurrentRewardsCubit currentRewardsCubit;

  final ChancesToWinCubit chancesToWinCubit;

  RewardSlotMachineCubit({
    this.currentRewardsCubit,
    this.chancesToWinCubit,
  }) : super("Spin for a chance of reward!");

  void spin() {
    var chanceToWin = chancesToWinCubit.state;
    Random random = Random();
    var max = 100;
    var value = random.nextInt(max);

    print(value);

    if(value > max - chanceToWin) {
      currentRewardsCubit.increment();
      emit("You won! A reward point has been added!");

    } else {
      emit("Good job on completing your quest! You might get a reward next run!");
    }
  }
}
