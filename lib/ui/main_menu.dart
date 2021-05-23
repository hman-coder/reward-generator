import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_generator/bloc/chance_to_win_cubit.dart';
import 'package:reward_generator/bloc/current_rewards_cubit.dart';
import 'package:reward_generator/bloc/reward_slot_machine_cubit.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reward Generator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCurrentRewardsRow(context),
          _buildChancesToWinRow(context),
          _buildSpinButton(context),
          _buildTextMessage(context),
        ],
      ),
    );
  }

  Widget _buildSpinButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context.read<RewardSlotMachineCubit>().spin(),
        child: Text("spin!"));
  }

  Widget _buildTextMessage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(context.watch<RewardSlotMachineCubit>().state),
    );
  }

  Widget _buildCurrentRewardsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Current rewards"),
        Text(context.watch<CurrentRewardsCubit>().state.toString()),
        ElevatedButton(
            onPressed: () => context.read<CurrentRewardsCubit>().claim(),
            child: Text("claim"))
      ],
    );
  }

  Widget _buildChancesToWinRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Chances to win: ",
          ),
        ),
        SizedBox(
          width: 80,
          child: TextField(
            decoration: InputDecoration(
              suffix: Text("%"),
            ),
            onChanged: (text) =>
                context.read<ChancesToWinCubit>().update(int.parse(text)),
            keyboardType: TextInputType.number,
            controller: TextEditingController(
                text: context.watch<ChancesToWinCubit>().state.toString()),
          ),
        ),
      ],
    );
  }
}
