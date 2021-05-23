import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_generator/repository/current_rewards_repository.dart';

class CurrentRewardsCubit extends Cubit<int> {
  final CurrentRewardsRepository _repository;

  CurrentRewardsCubit(this._repository) : super(-1) {
    _loadValueFromRepository();
  }

  void _loadValueFromRepository() async {
    int value = await _repository.fetch();
    emit(value);
  }

  void increment() async {
    int newValue = state + 1;
    await _repository.update(newValue);
    emit(newValue);
  }

  void claim() async {
    if (await _repository.update(0)) emit(0);
  }
}
