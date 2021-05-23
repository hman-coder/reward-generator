import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reward_generator/repository/chances_to_win_repository.dart';

class ChancesToWinCubit extends Cubit<int> {  
  final ChancesToWinRepository _repository;
  
  ChancesToWinCubit(this._repository) : super(-1) {
    _loadValueFromRepository();
  }

  void _loadValueFromRepository() async {
    var value = await _repository.fetch();
    emit(value);
  }
  
  void update(int value) async {
    if (await _repository.update(value)) {
      emit(value);
    }
  }
}